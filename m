Return-Path: <linux-kernel+bounces-552579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF34A57B94
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 16:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F1BD189116F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 15:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C6B1E1DF4;
	Sat,  8 Mar 2025 15:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="YEB9KXBS"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0423D1C84C1;
	Sat,  8 Mar 2025 15:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741447671; cv=none; b=EgLFu1eDR2zTi6uo07jKSIAXtGDG8YdjU/Lj51BI7fYCmozT+yvZZnePw3S5f82KVNw1Wou6n8xK16aG4+RMF11rR5Z/6n+KM5yurq/YhJPJfulmmWtDzNlVmzkoGZAnSxYTiDq5CA+FxGIuTXMGAXbH5VcKUgRXanwiEaWyuNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741447671; c=relaxed/simple;
	bh=BzbdGhFUgbWVE36GSc3NNkv4xumU2hEjxnkJ3qaNKvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fiizuFou6cunY2K3lfGUWzUupFP789RZuBdpHpmh2Me4A4PagkYhxfW8MKl/fbUT6reiFUpX4OeD4/HxOJ8om9WKt+70OaLp1Deg5WfmkXi4WgwevpWEc/XeDSuuyWQHOgovbUT1nR7OOW4XCnB9drs1RgnI8ITcaERrCde9Vsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=YEB9KXBS; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id C074025B9B;
	Sat,  8 Mar 2025 16:27:44 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DXIS_cdflHBn; Sat,  8 Mar 2025 16:27:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1741447664; bh=BzbdGhFUgbWVE36GSc3NNkv4xumU2hEjxnkJ3qaNKvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YEB9KXBSTSSxK41VGw2GC7PrpTTMzDI2U5XmJyAEGPEb94zjWE4AbiD0RxINY17+1
	 4XL7MXJ2AT3qa9I+ZIWh+m7STiSpUEkqX6fAXKH0s1CCkEaMGvh9z8PN/2+MgYWPXR
	 B4bfUgc/37PlGfmXwu9rla9qnEL6qjzdnvvYs78Mg6O5vGci6tDQ466GSBnnhH9PYj
	 3UrAyT9rSExMAcnggY3s6LrDSHHfttlQQhCvgtF2r307Hp7jZo0gfS3ZyjVIEjBZQy
	 xVRZxwEGWyOKmltxDOKfq1kPRdGDjlDbLF0+cbt0OmozVZSXlorn69J05DTnS63NHe
	 gwbQFasUTva3w==
Date: Sat, 8 Mar 2025 15:27:22 +0000
From: Yao Zi <ziyao@disroot.org>
To: Jonas Karlman <jonas@kwiboo.se>, Chukun Pan <amadeus@jmu.edu.cn>
Cc: conor+dt@kernel.org, cristian.ciocaltea@collabora.com,
	detlev.casanova@collabora.com, devicetree@vger.kernel.org,
	heiko@sntech.de, krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 8/8] arm64: dts: rockchip: Enable SD-card interface on
 Radxa E20C
Message-ID: <Z8xh2mE1BTE4co43@pie>
References: <20250305194638.47187-1-ziyao@disroot.org>
 <20250307033508.656479-1-amadeus@jmu.edu.cn>
 <Z8qJqpUwi7VV8tJk@pie>
 <5a0a7ce1-1dfb-4d19-8a1e-0d89d177f5b8@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a0a7ce1-1dfb-4d19-8a1e-0d89d177f5b8@kwiboo.se>

Hi Jonas,

On Fri, Mar 07, 2025 at 07:45:00AM +0100, Jonas Karlman wrote:
> Hi Chukun,
> 
> On 2025-03-07 06:52, Yao Zi wrote:
> > On Fri, Mar 07, 2025 at 11:35:08AM +0800, Chukun Pan wrote:
> >> Hi,
> >>
> >>> +&sdmmc {
> >>> +	bus-width = <4>;
> >>> +	cap-mmc-highspeed;
> >>> +	cap-sd-highspeed;
> >>> +	disable-wp;
> >>> +	no-sdio;
> >>
> >> With 'no-sdio' property:
> >> [  129.608986] mmc_host mmc1: Bus speed (slot 0) = 400000Hz (slot req 400000Hz, actual 400000HZ div = 0)
> >> [  130.711168] mmc1: Card stuck being busy! __mmc_poll_for_busy
> >> [  130.725536] mmc_host mmc1: Bus speed (slot 0) = 300000Hz (slot req 300000Hz, actual 300000HZ div = 0)
> >> [  131.751240] mmc1: Card stuck being busy! __mmc_poll_for_busy
> >> [  131.765608] mmc_host mmc1: Bus speed (slot 0) = 200000Hz (slot req 200000Hz, actual 200000HZ div = 0)
> >> [  132.825083] mmc1: Card stuck being busy! __mmc_poll_for_busy
> >> [  132.839413] mmc_host mmc1: Bus speed (slot 0) = 187500Hz (slot req 187500Hz, actual 187500HZ div = 0)
> >> [  133.960141] mmc1: Card stuck being busy! __mmc_poll_for_busy
> >>
> >> Without 'no-sdio' property:
> >> [  105.224019] mmc1: error -22 whilst initialising SDIO card
> >> [  106.290838] mmc1: Card stuck being busy! __mmc_poll_for_busy
> >> [  106.801931] dwmmc_rockchip ffc30000.mmc: Busy; trying anyway
> >> [  107.385835] mmc_host mmc1: Timeou sending command (cmd 0x202000 arg 0x0 status 0x80202000)
> >> [  107.400425] mmc_host mmc1: Bus speed (slot 0) = 300000Hz (slot req 300000Hz, actual 300000HZ div = 0)
> >> [  107.431561] mmc_host mmc1: Bus speed (slot 0) = 49800000Hz (slot req 50000000Hz, actual 49800000HZ div = 0)
> >> [  107.433107] mmc1: new high speed SDIO card at address 0001
> > 
> > So it seems the sdmmc controller actually works with SDIO commands as
> > well? I don't expect that since the datasheet says RK3528 has only two
> > SDIO 3.0 controllers.
> > 
> > We could remove the "no-sdio" property if SDIO actually works. Will
> > apply it in the next version if there's no objection against this.
> 
> On the E20C the sdmmc controller is routed to a microSD card slot mainly
> intended for use with microSD-cards and should normally not need SDIO.

As pointed out by Chukun, I found the hardware design guide for
RK3528[1] (in Chinese) does claim that SDIO 3.0 is supported on all
these three controllers in Chapter 2.3.1 (SDMMC/SDIO),

  RK3528 集成了 1 个 SDMMC 控制器和 2 个 SDIO 控制器，均可支持 SDIO3.0 协
  议，以及 MMC V4.51 协议。其中 SDIO0 和 SDIO1 最高可支持 200MHz，SDMMC
  最高只支持到 150MHz

translated to English,

  RK3528 integrates one SDMMC controller and two SDIO controllers, all
  support SDIO3.0 protocol and MMC V4.51 protocol. Among them SDIO0 and
  SDIO1 support 200MHz frequency at maximum, and SDMMC supports up to
  150MHz.

So I think there's no reason to explicitly deny SDIO initialization
sequence for the controller on Radxa E20C. imho this won't break
anything even for a sdcard slot, will it?

Additionally, this piece of information points out that wrong
max-frequency is set for SDIO{0,1}. Rockchip overrides the frequency in
devicetrees for the demo boards[2], I'm not sure whether it's for some
speical reason or not.

Since I don't have a SDIO-capable board on hand, could you please test
whether 200MHz actually works? If so I'll correct the SoC devicetree in
v3.

> What card/adapter do you have inserted in the microSD card slot that
> requires use of SDIO instead of just SD or MMC? What is the use case you
> have that requires removal of no-sdio on E20C?
> 
> Regards,
> Jonas
> 
> > 
> > Further tests about the capabilities of the controller are welcome.
> > 
> >> # cat /sys/kernel/debug/mmc1/ios
> >> clock:          50000000 Hz
> >> vdd:            21 (3.3 ~ 3.4 V)
> >> bus mode:       2 (push-pull)
> >> chip select:    0 (don't care)
> >> power mode:     2 (on)
> >> bus width:      2 (4 bits)
> >> timing spec:    2 (sd high-speed)
> >> signal voltage: 0 (3.30 V)
> >> driver type:    0 (driver type B)
> >>
> >> Thanks,
> >> Chukun
> >>
> >> -- 
> >> 2.25.1
> >>
> > 
> > Best regards,
> > Yao Zi
> 

Thanks,
Yao Zi

[1]: https://github.com/DeciHD/rockchip_docs/blob/main/rk3528/RK3528%20Hardware%20Design%20Guide-CN-V1.0-20230525.pdf
[2]: https://github.com/rockchip-linux/kernel/blob/604cec4004abe5a96c734f2fab7b74809d2d742f/arch/arm64/boot/dts/rockchip/rk3528-demo1-lp4-v10.dtsi#L47

