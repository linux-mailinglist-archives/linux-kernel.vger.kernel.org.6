Return-Path: <linux-kernel+bounces-407639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB779C7056
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2EE81F2139B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A351E04A2;
	Wed, 13 Nov 2024 13:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="PJtXT4LK"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DD21DE3CA;
	Wed, 13 Nov 2024 13:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731503532; cv=none; b=MZfFzxogtHaWhw0EBw2ZaAjC0unLfUomj1V+TWGFTvOGHtJzC17BbDCY1HRkTKnVDVXJQ4xjOvV+lniSwmQasbfX6vqFrYQcd//7S80YBRzD2ureVRfoc1g+xflkk6Lkr9HSTuhpQqRz43Gzvu5B18GbwP7TJDvQ1tmEihxU57I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731503532; c=relaxed/simple;
	bh=wFh7kXldyLqNCa6sxY5WzyOfpchYIA4lSf9YzeARiKk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=VOydGnsk131RXqKSUqralHKNM0ulr5yv8AdFO/8Kj64GE+jEtNdjJlKMB6Dfo4EKWt39rQ9XOL0Kg6VL0KRs1AROxyWFSyUB5ur/Pk2MbbGXUBqxW/Mq0Y1CMgWS6xKVDnRg2IFtubU+I/9HOXdozdkB7KtoCRV02ouageays0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=PJtXT4LK; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1731503528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5nbqMK/vu5S+EB8yB3j6/LM3bRJoguYvwGMWQ/46LZk=;
	b=PJtXT4LKXzMdwKPDnSFOu2Zu5pLcSSqZyrhtfdFdRp3nsgHkNp75NTmSyCZ0KsXk/Vdttr
	cXGDeY6bFxmzhtcbPAgdL/ilrU1OxmenfyFD611R/gPUGmRJs4yGP4y60Ierqnxbl+WtRZ
	8Gg7RsmG5kYaNEr2WHYfYssVkdgry/uU6nJR66QbWo4QnBl/ylJiNgDfCFN+MvskoSUqLs
	wm51Ly/fDEo9Sl/KQHeThFL13VZ5U2v8ejevruNygDtxFKa6QlREIwVHfesOfg7QU27hSr
	R7imDatYBIldY5SxmIZQTMlaFVW9R8ht2BrMmvI5JdkFtRbD+q+KPh4aA4v29w==
Date: Wed, 13 Nov 2024 14:12:07 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Tam=C3=A1s_Sz=C5=B1cs?= <tszucs@linux.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, FUKAUMI Naoki
 <naoki@radxa.com>, Chukun Pan <amadeus@jmu.edu.cn>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: rockchip: Enable sdmmc2 on rock-3b and
 set it up for SDIO devices
In-Reply-To: <CA+Gksr+6pjsHY=Mx2gmPnTV6TRbD_4dXptAqph8RSpR1pR9LtA@mail.gmail.com>
References: <20241111181807.13211-1-tszucs@linux.com>
 <20241111181807.13211-3-tszucs@linux.com>
 <9fbdf05c-42e6-4ac5-9542-805200bc8c87@kwiboo.se>
 <260af427ae64d6f3b02a1579ee83eb3b@manjaro.org>
 <CA+Gksr+WvS-S+jeYYG=Bo9cemvnJmjsmU4aj9YnD3t8-HY7wbw@mail.gmail.com>
 <303ad3910668e852d6670d1c79dc22e0@manjaro.org>
 <CA+GksrLLbfyHdvu1VYB4S+W78C0T1DEWu5W6pP2-g3KdBeT-LQ@mail.gmail.com>
 <eed7f35d1311eced9144fd7a5656b58f@manjaro.org>
 <CA+Gksr+aoDazT3b7uPFTOf5h3Drn3idZ5Kiris3k1fAxweXcyQ@mail.gmail.com>
 <7229c5a3e9cef5dc05f6c42a846fcd29@manjaro.org>
 <CA+Gksr+6pjsHY=Mx2gmPnTV6TRbD_4dXptAqph8RSpR1pR9LtA@mail.gmail.com>
Message-ID: <3b0fbf639ac2f6cce233049a941ece04@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Tamas,

On 2024-11-13 12:17, Tamás Szűcs wrote:
> On Wed, Nov 13, 2024 at 11:44 AM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> On 2024-11-13 11:24, Tamás Szűcs wrote:
>> > On Wed, Nov 13, 2024 at 12:38 AM Dragan Simic <dsimic@manjaro.org>
>> > wrote:
>> >> On 2024-11-12 22:05, Tamás Szűcs wrote:
>> >> > On Tue, Nov 12, 2024 at 4:16 PM Dragan Simic <dsimic@manjaro.org>
>> >> > wrote:
>> >> >> On 2024-11-12 15:35, Tamás Szűcs wrote:
>> >> >> > I think it was totally fine to disable sdmmc2 at first, especially if
>> >> >> > it couldn’t be tested or wasn’t needed right away. From what I’ve
>> >> >> > seen, this board works great even at higher clock speeds than what
>> >> >> > rk356x-base.dtsi suggests. I don’t have access to the RK3568 errata,
>> >> >> > and there don’t seem to be any limits mentioned in the TRM either.
>> >> >> > Overall, this board is doing just fine as it is.
>> >> >>
>> >> >> Sorry, I'm missing the point of mentioning some clock speeds?  Any
>> >> >> chances, please, to clarify that a bit?
>> >> >
>> >> > It's all about stress scenarios, right. Sustained transfer at maximum
>> >> > clock, multiple SD/MMC blocks used concurrently. That kind of thing.
>> >> > Different data rates forced. I hope that answers your question.
>> >>
>> >> Ah, I see.  Though, I don't think we should worry much about that,
>> >> although testing it all is, of course, a good thing to do.
>> >
>> > Better be safe than sorry. Let's just say I've seen worse.
>> >
>> >> >> > Regarding device tree overlays, they would be ideal for implementing
>> >> >> > secondary functions, such as PCIe endpoint mode for users with
>> >> >> > specific requirements. However, the primary functions for PCIe on the
>> >> >> > M2E will be root complex mode, along with SDIO host, etc. In my view,
>> >> >> > the hardware is well-designed and interconnected. Users have a
>> >> >> > reasonable expectation that these primary functions should work
>> >> >> > seamlessly without additional configuration, right out of the box.
>> >> >>
>> >> >> That's basically what I referred to in my earlier response, and in my
>> >> >> previous response regarding the UART.  Users would expect the
>> >> >> Bluetooth
>> >> >> part to work as well, but the error messages I mentioned look nasty,
>> >> >> so
>> >> >> perhaps something should be done about that first.
>> >> >
>> >> > I'm not aware of any nasty error messages especially related to UART.
>> >> > Well, MMC core will acknowledge when the platform part fails to
>> >> > enumerate a device on sdmmc2, but there's nothing wrong with this.
>> >> > It's not even an error -- certainly not a nasty one.
>> >> >
>> >> > [    1.799703] mmc_host mmc2: card is non-removable.
>> >> > [    1.935011] mmc_host mmc2: Bus speed (slot 0) = 375000Hz (slot req
>> >> > 400000Hz, actual 375000HZ div = 0)
>> >> > [    7.195009] mmc_host mmc2: Bus speed (slot 0) = 375000Hz (slot req
>> >> > 375000Hz, actual 375000HZ div = 0)
>> >> > [   13.029540] mmc2: Failed to initialize a non-removable card
>> >>
>> >> This looks acceptable to me, but I'm now not really sure that we
>> >> should enable the sdmmc2 in the board dts.  Let me explain.
>> >>
>> >> As Jonas demonstrated with the WiFi+Bluetooth DT overlay, additional
>> >> DT configuration is needed to actually make an SDIO M.2 module plugged
>> >> into the ROCK 3B's M.2 slot work, so what do we actually get from
>> >> enabling the sdmmc2 in the board dts?  Just some error messages in
>> >> the kernel log :) and AFAICT no additional functionality when an SDIO
>> >> M.2 module is actually plugged into the slot.
>> >
>> > I think if you want to add a specific bluetooth DT overlay for your
>> > favorite module, you should.
>> > Our modules need this much and it's very useful already. I'm not
>> > interested in nailing down every single one we have in a separate
>> > overlay at this point.
>> 
>> It would help if you'd share more details about the M.2 SDIO
>> module you're referring to, please.
> 
> Kindly refer to 3/3.

Just had a look at that product list page, and even tried having
a look at MAYA-W4_ProductSummary_UBXDOC-465451970-3565.pdf, for
example, and all I see are some high-level product descriptions,
with no technical details we'd need to have a look at.

>> >> >> > Dragan, what did you mean by SDIO related power timing requirements?
>> >> >>
>> >> >> Whenever there's an SDIO module, there's usually some required timing
>> >> >> of the power rails.  Though, I don't know what's that like with the
>> >> >> non-standard M.2 SDIO modules that Radxa sells, which are intended to
>> >> >> be used on Radxa boards with "hybrid" M.2 slots.
>> >> >
>> >> > Ok, I see. Not always. I can't comment on Radxa's SDIO module but I'm
>> >> > sure it's reasonably standard. And so is the M.2 Key E on this board.
>> >> > Actually, part of the appeal is that all standard buses are very
>> >> > nicely wired up. I want everybody to be able to use them.
>> >>
>> >> Yes, but getting it all wired in some way unfortunately doesn't mean
>> >> that it will all work without additional DT configuration in place,
>> >> as described above.
>> >
>> > Agreed, well these are the common changes needed.
>> 
>> They are common indeed, but unless demonstrated they're all that's
>> needed to get some M.2 SDIO module fully functional, it escapes me
>> to see what are the benefits of including (and more importantly,
>> enabling) these changes under the umbrella of commonality.
> 
> Please don't make it look harder than it is. Load device driver,
> download firmware(s), you're set.

Well, all I can say to this is that you may be making the things
look way simpler than they usually are.  Though, let's also see
what other people will respond with.

>> >> Also, I'm not really sure there's some strict standard for the "GPIO"
>> >> and "UART" M.2 modules, that part of the specification was/is a bit
>> >> blurry or perhaps even non-existent.  It's been a while since I wrote
>> >> the M.2 aricle on English Wikipedia, :) maybe it's become defined
>> >> better in the meantime.
>> >>
>> >> >> Once again, please use inline replying. [*]
>> >> >>
>> >> >> [*] https://en.wikipedia.org/wiki/Posting_style
>> >> >>
>> >> >> > On Tue, Nov 12, 2024 at 5:41 AM Dragan Simic <dsimic@manjaro.org>
>> >> >> > wrote:
>> >> >> >>
>> >> >> >> Hello Jonas and Tamas,
>> >> >> >>
>> >> >> >> On 2024-11-11 20:06, Jonas Karlman wrote:
>> >> >> >> > On 2024-11-11 19:17, Tamás Szűcs wrote:
>> >> >> >> >> Enable SDIO on Radxa ROCK 3 Model B M.2 Key E. Add all supported UHS-I
>> >> >> >> >> rates and
>> >> >> >> >> enable 200 MHz maximum clock. Also, allow host wakeup via SDIO IRQ.
>> >> >> >> >>
>> >> >> >> >> Signed-off-by: Tamás Szűcs <tszucs@linux.com>
>> >> >> >> >> ---
>> >> >> >> >>  arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts | 8 +++++++-
>> >> >> >> >>  1 file changed, 7 insertions(+), 1 deletion(-)
>> >> >> >> >>
>> >> >> >> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
>> >> >> >> >> b/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
>> >> >> >> >> index 242af5337cdf..b7527ba418f7 100644
>> >> >> >> >> --- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
>> >> >> >> >> +++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
>> >> >> >> >> @@ -688,14 +688,20 @@ &sdmmc2 {
>> >> >> >> >>      cap-sd-highspeed;
>> >> >> >> >>      cap-sdio-irq;
>> >> >> >> >>      keep-power-in-suspend;
>> >> >> >> >> +    max-frequency = <200000000>;
>> >> >> >> >>      mmc-pwrseq = <&sdio_pwrseq>;
>> >> >> >> >>      non-removable;
>> >> >> >> >>      pinctrl-names = "default";
>> >> >> >> >>      pinctrl-0 = <&sdmmc2m0_bus4 &sdmmc2m0_clk &sdmmc2m0_cmd>;
>> >> >> >> >> +    sd-uhs-sdr12;
>> >> >> >> >> +    sd-uhs-sdr25;
>> >> >> >> >> +    sd-uhs-sdr50;
>> >> >> >> >
>> >> >> >> > I thought that lower speeds was implied by uhs-sdr104?
>> >> >> >>
>> >> >> >> Last time I went through the MMC drivers, they were implied.  IIRC,
>> >> >> >> such backward mode compatibility is actually a requirement made by
>> >> >> >> the MMC specification.
>> >> >> >>
>> >> >> >> >>      sd-uhs-sdr104;
>> >> >> >> >> +    sd-uhs-ddr50;
>> >> >> >> >>      vmmc-supply = <&vcc3v3_sys2>;
>> >> >> >> >>      vqmmc-supply = <&vcc_1v8>;
>> >> >> >> >> -    status = "disabled";
>> >> >> >> >> +    wakeup-source;
>> >> >> >> >> +    status = "okay";
>> >> >> >> >
>> >> >> >> > This should probably be enabled using an dt-overlay, there is no
>> >> >> >> > SDIO device embedded on the board and the reason I left it disabled
>> >> >> >> > in original board DT submission.
>> >> >> >>
>> >> >> >> Just went through the ROCK 3B schematic, version 1.51, and I think
>> >> >> >> there should be no need for a separate overlay, because sdmmc2 goes
>> >> >> >> to the M.2 slot on the board, which any user can plug an M.2 module
>> >> >> >> into, and the SDIO interface is kind-of self-discoverable.
>> >> >> >>
>> >> >> >> Of course, all that unless there are some horribly looking :) error
>> >> >> >> messages emitted to the kernel log when nothing is actually found,
>> >> >> >> in which case the SDIO/MMC driers should be fixed first.  Also, I'm
>> >> >> >> not sure what do we do with the possible SDIO-related power timing
>> >> >> >> requirements?

