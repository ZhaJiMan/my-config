#Requires AutoHotkey v2.0

#SingleInstance Force

/*
; https://www.reddit.com/r/AutoHotkey/comments/1cx02oh/help_needed_converting_ahk_v1_spacefn_script_to/
class SpaceFn {
    static isHeld := false

    ; 按下空格超过指定时间则变成 fn
    static holdCheck() {
        if KeyWait("Space", "T0.15") {
            Send("{Space}")
        } else {
            spacefn.isHeld := true
            KeyWait("Space")
            spacefn.isHeld := false
        }
    }
}

#HotIf SpaceFn.isHeld
    *e::Up
    *d::Down
    *s::Left
    *f::Right
#HotIf

*Space::SpaceFn.holdCheck()
*/

; https://qiita.com/tawara_/items/d40e0284135ca4a629b7
class SpaceFn {
    static isHeld := false
    static isTriggered := false

    ; 按住空格时如果触发不触发其它键，那么结束后输出空格
    static up() {
        if !SpaceFn.isTriggered {
            Send("{Blind}{Space}")
        }
        SpaceFn.isHeld := false
        SpaceFn.isTriggered := false
    }

    static send(key) {
        SpaceFn.isTriggered := true
        Send(key)
    }

    static sendBlind(key) {
        SpaceFn.send("{Blind}" . key)
    }

    static run(target) {
        SpaceFn.isTriggered := true
        Run(target)
    }
}

*Space::SpaceFn.isHeld := true
*Space up::SpaceFn.up()

*CapsLock::LCtrl

#HotIf SpaceFn.isHeld
    *e::SpaceFn.sendBlind("{Up}")
    *d::SpaceFn.sendBlind("{Down}")
    *s::SpaceFn.sendBlind("{Left}")
    *f::SpaceFn.sendBlind("{Right}")

    *1::SpaceFn.sendBlind("{F1}")
    *2::SpaceFn.sendBlind("{F2}")
    *3::SpaceFn.sendBlind("{F3}")
    *4::SpaceFn.sendBlind("{F4}")
    *5::SpaceFn.sendBlind("{F5}")
    *6::SpaceFn.sendBlind("{F6}")
    *7::SpaceFn.sendBlind("{F7}")
    *8::SpaceFn.sendBlind("{F8}")
    *9::SpaceFn.sendBlind("{F9}")
    *0::SpaceFn.sendBlind("{F10}")
    *-::SpaceFn.sendBlind("{F11}")
    *=::SpaceFn.sendBlind("{F12}")

    *h::SpaceFn.sendBlind("{Home}")
    *l::SpaceFn.sendBlind("{End}")
    *m::SpaceFn.sendBlind("{PgDn}")
    *,::SpaceFn.sendBlind("{PgUp}")
    *j::SpaceFn.SendBlind("^{Left}")
    *k::SpaceFn.SendBlind("^{Right}")
    *n::SpaceFn.sendBlind("^{End}")
    *.::SpaceFn.sendBlind("^{Home}")
    *u::SpaceFn.Send("^{Backspace}")
    *i::SpaceFn.Send("^{Delete}")
    *o::SpaceFn.Send("{End}{Enter}")

    ; */::SpaceFn.sendBlind("{\}")
    *Backspace::SpaceFn.sendBlind("{Delete}")
    *Tab::SpaceFn.sendBlind("{CapsLock}")

    *q::SpaceFn.send("!{F4}")
    *w::SpaceFn.send("#{d}")
    *c::SpaceFn.send("^{Insert}")
    *v::SpaceFn.send("+{Insert}")
    *a::SpaceFn.send("{Volume_Up}")
    *z::SpaceFn.send("{Volume_Down}")
    *t:: SpaceFn.run("taskmgr")
#HotIf
