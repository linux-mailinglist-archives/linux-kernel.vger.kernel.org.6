Return-Path: <linux-kernel+bounces-550500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A86EA56071
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 06:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 446003A88F9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 05:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29B21991A1;
	Fri,  7 Mar 2025 05:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="AOZJ9o5F"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407481C27;
	Fri,  7 Mar 2025 05:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741326785; cv=none; b=YMkFZ2jL9rdT/pmWGPuisph/Rd++W3KjHJPpVESRxppGmoU1kvzSUgzYbvy4Nnl2RxQ1rPaiu3GPCs0frhG24Se49HqbGs39hRKhR1CJ7daYmibNawYXbArnQtlMZpOL9qRwuHaJ/8ZCDJMpI+4WXGvaKvfchJwTqv1wU8/Q4fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741326785; c=relaxed/simple;
	bh=8pUgSgop8ysTVfRFBXPiQaRHFFGbXmooM4lxtk87R90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjGaJq1oOO8jxnJ9ZWWZvTX4mS7sYb4AZY/khJE6Vb8/XxDVDkXpjBkVNif5BW94r4jxUToPSNLydHU7lkxW0Q2wNHDBUX5AWi6o9rHw7abwJI5YpBEHsnQa2bosOhD3hjc1oROSuvYAmRG0Zy/cKK/OGD+geREmBoHPXimeMgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=AOZJ9o5F; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 1E15425D53;
	Fri,  7 Mar 2025 06:52:59 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tckWDYJ3Tzh5; Fri,  7 Mar 2025 06:52:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1741326778; bh=8pUgSgop8ysTVfRFBXPiQaRHFFGbXmooM4lxtk87R90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AOZJ9o5FvW8yfwecTcbsNRyFRpzyskfWAfP8kCR0cykMVfEp3cnzJUryHx1DxeEYh
	 p3MsEvNrV3rvJencFZY1bQERwvUPvH1zgd5RsKXwdnEXuoYDKaRcW4XbiEUtunLxRw
	 b0yHFE/cOsdfgQ1y9kotL5mg0VVt1Qc2Rq/DobUuFkohMiutlIqopJXbDFG4+TsMiY
	 PzDkpIT6teC+LBBIGipyajKr45tBW+C9FarX8+euI6lkalw+53DIYdiArukvfPAyeG
	 2HoUaEG1audW1E9M2y525bHuexgCGddvX+I5Qe/AP271yw9lj2reCV/tjvtvIoY2d4
	 YpIzFCRidQNtg==
Date: Fri, 7 Mar 2025 05:52:42 +0000
From: Yao Zi <ziyao@disroot.org>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: conor+dt@kernel.org, cristian.ciocaltea@collabora.com,
	detlev.casanova@collabora.com, devicetree@vger.kernel.org,
	heiko@sntech.de, jonas@kwiboo.se, krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 8/8] arm64: dts: rockchip: Enable SD-card interface on
 Radxa E20C
Message-ID: <Z8qJqpUwi7VV8tJk@pie>
References: <20250305194638.47187-1-ziyao@disroot.org>
 <20250307033508.656479-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307033508.656479-1-amadeus@jmu.edu.cn>

On Fri, Mar 07, 2025 at 11:35:08AM +0800, Chukun Pan wrote:
> Hi,
> 
> > +&sdmmc {
> > +	bus-width = <4>;
> > +	cap-mmc-highspeed;
> > +	cap-sd-highspeed;
> > +	disable-wp;
> > +	no-sdio;
> 
> With 'no-sdio' property:
> [  129.608986] mmc_host mmc1: Bus speed (slot 0) = 400000Hz (slot req 400000Hz, actual 400000HZ div = 0)
> [  130.711168] mmc1: Card stuck being busy! __mmc_poll_for_busy
> [  130.725536] mmc_host mmc1: Bus speed (slot 0) = 300000Hz (slot req 300000Hz, actual 300000HZ div = 0)
> [  131.751240] mmc1: Card stuck being busy! __mmc_poll_for_busy
> [  131.765608] mmc_host mmc1: Bus speed (slot 0) = 200000Hz (slot req 200000Hz, actual 200000HZ div = 0)
> [  132.825083] mmc1: Card stuck being busy! __mmc_poll_for_busy
> [  132.839413] mmc_host mmc1: Bus speed (slot 0) = 187500Hz (slot req 187500Hz, actual 187500HZ div = 0)
> [  133.960141] mmc1: Card stuck being busy! __mmc_poll_for_busy
> 
> Without 'no-sdio' property:
> [  105.224019] mmc1: error -22 whilst initialising SDIO card
> [  106.290838] mmc1: Card stuck being busy! __mmc_poll_for_busy
> [  106.801931] dwmmc_rockchip ffc30000.mmc: Busy; trying anyway
> [  107.385835] mmc_host mmc1: Timeou sending command (cmd 0x202000 arg 0x0 status 0x80202000)
> [  107.400425] mmc_host mmc1: Bus speed (slot 0) = 300000Hz (slot req 300000Hz, actual 300000HZ div = 0)
> [  107.431561] mmc_host mmc1: Bus speed (slot 0) = 49800000Hz (slot req 50000000Hz, actual 49800000HZ div = 0)
> [  107.433107] mmc1: new high speed SDIO card at address 0001

So it seems the sdmmc controller actually works with SDIO commands as
well? I don't expect that since the datasheet says RK3528 has only two
SDIO 3.0 controllers.

We could remove the "no-sdio" property if SDIO actually works. Will
apply it in the next version if there's no objection against this.

Further tests about the capabilities of the controller are welcome.

> # cat /sys/kernel/debug/mmc1/ios
> clock:          50000000 Hz
> vdd:            21 (3.3 ~ 3.4 V)
> bus mode:       2 (push-pull)
> chip select:    0 (don't care)
> power mode:     2 (on)
> bus width:      2 (4 bits)
> timing spec:    2 (sd high-speed)
> signal voltage: 0 (3.30 V)
> driver type:    0 (driver type B)
> 
> Thanks,
> Chukun
> 
> -- 
> 2.25.1
> 

Best regards,
Yao Zi

