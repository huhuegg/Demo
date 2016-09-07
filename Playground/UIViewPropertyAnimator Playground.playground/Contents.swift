//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport


public enum ButtonType {
    case start,
    pause,
    stop,
    reverse,
    finishAtCurrent,
    jumpTo
}


public protocol ControllerBarAnimationProtocol {
    func initAnimator()
    func initAnimations()
    func addController(animator:UIViewPropertyAnimator)

}
public class ControllerBar:UIView {
    var delegate:ControllerBarAnimationProtocol?
    
    var slider:UISlider!
    var jumpToPositionButton:UIButton!
    var startButton:UIButton!
    var pauseButton:UIButton!
    var reverseButton:UIButton!
    var stopButton:UIButton!
    var finishAtCurrentButton:UIButton!

    var sliderEventListener:EventListener!
    var jumpToPositionButtonEventListener:EventListener!
    var startButtonEventListener:EventListener!
    var pauseButtonEventListener:EventListener!
    var reverseButtonEventListener:EventListener!
    var stopButtonEventListener:EventListener!
    var finishAtCurrentButtonEventListener:EventListener!
    
    var animator:UIViewPropertyAnimator!
    var isPaused:Bool = false

    init(frame: CGRect, animator:UIViewPropertyAnimator, delegate:ControllerBarAnimationProtocol?) {
        super.init(frame: frame)
        self.animator = animator
        self.delegate = delegate
        initView()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initView() {
        func createButton(frame:CGRect, title:String)->UIButton {
            let button = UIButton(frame:frame)
            button.backgroundColor = UIColor.gray
            button.titleLabel?.textColor = UIColor.white
            button.setTitle(title, for: UIControlState.normal)
            return button
        }

        //slider
        slider = UISlider(frame: CGRect(x: 0, y: 0, width: frame.width - 90, height: 50))
        jumpToPositionButton = createButton(frame: CGRect(x: frame.width - 75, y:5, width: 70, height: 40), title: "跳转")

        startButton = createButton(frame: CGRect(x: 0, y: 60, width: 60, height: 40), title:"开始")
        pauseButton = createButton(frame: CGRect(x: 70, y: 60, width: 60, height: 40), title:"暂停")
        reverseButton = createButton(frame: CGRect(x: 140, y: 60, width: 60, height: 40), title:"回滚")
        stopButton = createButton(frame: CGRect(x: 210, y: 60, width: 60, height: 40), title:"结束")
        finishAtCurrentButton = createButton(frame: CGRect(x: 280, y: 60, width: 150, height: 40), title:"在当前位置结束")

        addSliderEventListener()
        addButtonEventListener(type:.jumpTo)
        addButtonEventListener(type:.start)
        addButtonEventListener(type:.pause)
        addButtonEventListener(type:.reverse)
        addButtonEventListener(type:.stop)
        addButtonEventListener(type:.finishAtCurrent)

        self.addSubview(slider)
        self.addSubview(jumpToPositionButton)
        self.addSubview(startButton)
        self.addSubview(pauseButton)
        self.addSubview(reverseButton)
        self.addSubview(stopButton)
        self.addSubview(finishAtCurrentButton)
    }

    func addSliderEventListener() {
        sliderEventListener = EventListener()

        //添加Slide value变化回调
        sliderEventListener.eventFired = {
            //self.animator.fractionComplete = CGFloat(self.slider.value)
        }

        slider.addTarget(sliderEventListener, action: #selector(EventListener.handleEvent), for: .valueChanged)
    }

    func addButtonEventListener(type:ButtonType) {
        switch type {
        case .jumpTo:
            jumpToPositionButtonEventListener = EventListener()
            jumpToPositionButtonEventListener.eventFired = {
                switch self.animator.state {
                case .active:
                    print("操作：切换动画进度到:\(String(format:"%.2f%%",CGFloat(self.slider.value) * 100))")
                    
                    self.animator.fractionComplete = CGFloat(self.slider.value)
                    break
                default:
                    print("当前状态无法执行切换进度操作")
                    break
                }
            }
            jumpToPositionButton.addTarget(jumpToPositionButtonEventListener, action: #selector(EventListener.handleEvent), for: .touchUpInside)
            break
        case .start:
            startButtonEventListener = EventListener()
            startButtonEventListener.eventFired = {
                switch self.animator.state {
                case .inactive:
                    print("状态：动画尚未开始")
                    print("操作：添加动画并开始")
                    self.delegate?.initAnimations()
                    self.animator.startAnimation()
                    self.isPaused = false
                case .active:
                    print("状态：动画已经开始了")
                default:
                    break
                }
                
            }
            startButton.addTarget(startButtonEventListener, action: #selector(EventListener.handleEvent), for: .touchUpInside)
            break
        case .pause:
            pauseButtonEventListener = EventListener()
            pauseButtonEventListener.eventFired = {
                switch self.animator.state {
                case .inactive:
                    print("状态：动画尚未开始")
                    self.delegate?.initAnimations()
                    self.animator.startAnimation()
                    self.isPaused = false
                case .active:
                    print("状态：动画已经开始了")
                    if self.isPaused {
                        print("当前状态 -> 暂停")
                        print("操作：继续动画过程")
                        self.animator.startAnimation()
                        self.isPaused = false
                    } else {
                        print("当前状态 -> 动画过程中")
                        print("操作：执行暂停操作")
                        self.animator.pauseAnimation()
                        self.isPaused = true
                    }
                    
                default:
                    print("当前状态无法执行暂停或恢复操作")
                    break
                }

            }
            pauseButton.addTarget(pauseButtonEventListener, action: #selector(EventListener.handleEvent), for: .touchUpInside)
            break
        case .reverse:
            reverseButtonEventListener = EventListener()
            reverseButtonEventListener.eventFired = {
                switch self.animator.state {
                case .inactive:
                    print("状态：动画尚未开始，无法执行回滚操作")
                case .active:
                    print("状态：动画已经开始了")
                    if self.isPaused {
                        print("当前状态 -> 暂停")
                        print("操作：继续动画过程并回滚")
                        self.animator.startAnimation()
                        self.isPaused = false
                        self.animator.isReversed = true
    
                    } else {
                        print("当前状态 -> 动画过程中")
                        print("操作：回滚动画")
                        self.animator.isReversed = true
                    }
                    
                default:
                    print("当前状态无法执行回滚操作")
                    break
                }
                
            }
            reverseButton.addTarget(reverseButtonEventListener, action: #selector(EventListener.handleEvent), for: .touchUpInside)
            break
        case .stop:
            stopButtonEventListener = EventListener()
            stopButtonEventListener.eventFired = {
                self.animator.stopAnimation(true)
            }
            stopButton.addTarget(stopButtonEventListener, action: #selector(EventListener.handleEvent), for: .touchUpInside)
            break
        case .finishAtCurrent:
            finishAtCurrentButtonEventListener = EventListener()
            finishAtCurrentButtonEventListener.eventFired = {
                switch self.animator.state {
                    case .active:
                        print("在当前进度结束动画")
                        //仅进入停止状态
                        self.animator.stopAnimation(false)
                        //进入停止状态后调用，结束动画， 状态对应addCompletion的回调返回参数position
                        self.animator.finishAnimation(at:.current)
                    default:
                        print("当前状态无法执行结束动画操作")
                        break
                }
            }
            finishAtCurrentButton.addTarget(finishAtCurrentButtonEventListener, action: #selector(EventListener.handleEvent), for: .touchUpInside)
            break
        }
    }
}

public class TestPropertyAnimatorView:UIView {
    var controllerView:UIView!
    var imageView:UIImageView!
    
    var animator:UIViewPropertyAnimator!
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        initView()
        
        initAnimator()
        addController(animator: animator)

    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //添加需要做动画的View
    func initView() {
        let image = UIImage(named: "growingup_108")
        imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: 108, height: 108)
        
        imageView.center = {
            let x = (frame.minX + imageView.frame.width / 2)
            let y = (frame.maxY - imageView.frame.height / 2)
            
            return CGPoint(x: x, y: y)
        }()
        self.addSubview(imageView)
    }
}

extension TestPropertyAnimatorView: ControllerBarAnimationProtocol {
    public func initAnimator() {
        animator = UIViewPropertyAnimator(duration: 5, curve: UIViewAnimationCurve.easeIn)
    }
    
    public func addController(animator:UIViewPropertyAnimator) {
        
        controllerView = ControllerBar(frame: CGRect(x: 0, y: 0, width: frame.width, height: 100), animator: animator, delegate:self)
        self.addSubview(controllerView)
    }
    
    //添加动画
    public func initAnimations() {
        print("initAnimations")
        imageView.frame = CGRect(x: 0, y: 0, width: 108, height: 108)
        self.imageView.transform = CGAffineTransform(scaleX: 1, y: 1)
        imageView.center = {
            let x = (frame.minX + imageView.frame.width / 2)
            let y = (frame.maxY - imageView.frame.height / 2)
            
            return CGPoint(x: x, y: y)
        }()
        
        animator.addAnimations {
            self.imageView.center = liveView.center
        }
        
        animator.addAnimations {
            self.imageView.transform = CGAffineTransform(scaleX: 2, y: 2)
        }
        
        animator.addCompletion {
            position in
            switch position {
            case .end:
                print("动画结束回调: 动画结束")
            case .current:
                print("动画结束回调: 动画在当前进度结束")
            case .start:
                print("动画结束回调: 动画回滚结束")
            }
        }
    }
}


//创建liveView
let liveView = TestPropertyAnimatorView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))

//设置为当前展示的View
PlaygroundPage.current.liveView = liveView
//liveView.initAnimations()
//liveView.animator.startAnimation()

