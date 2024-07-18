Return-Path: <linux-kernel+bounces-256128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D81E3934973
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 162871C21A82
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 07:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A52578274;
	Thu, 18 Jul 2024 07:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="isS/dPJP"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7D336B17;
	Thu, 18 Jul 2024 07:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721289540; cv=none; b=TvmGjM1KY7Xt1V3q673uDoTirlvLbp9LEXB09qYYgT5rvqUjecD93oVLA1p14mNtE8yXz2SIhuGOjknPFDdVlEnO2hFrZWeikVNXL8kpXgzu5by3qHm4SegtzIsI0f0mlYzOom7cOFwhQw/NcXhq7Nhfd4rJrZvxhi1+mDp5sf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721289540; c=relaxed/simple;
	bh=XMwFf7Wf1Zg2/2hGbaEOkR0HLHQZ2nU+Tgh5Y3+wV/s=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Y6vbF9zOyK4/lAA5vj2eWeFUSYVEosKrl+4lt5R/m4yDedZOu/EwJXvTzEqXeIvbLIZzfaNDUavlN/HG4bmmRdYzqmwdIzmHO2QAl08U1rdKQrirnHghJvVrJf1F/9NNsJPU4++Z0OJTvtzYDCZvYzo/tODKdtSGIugsqBPEjwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=isS/dPJP; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1721289536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mtt1ez6V0zk2MdNMt3EH626hc/PXnX2HobUacwKbti8=;
	b=isS/dPJPsmGvct89HID4hfB8oq+ywJh8gDFL+VPEXkTdtceBFz7hmwbIek3nF0SHT7TmTu
	WMxQqjAEUHsEJj/tmEJHePCo24CBXDaMBs+IsseCwXs7m29oz8B/EKnE5a8gC3+KrSdqNt
	IO3zZr6Uon23rWJY9jF/qEpPVJ275go1ss34PqnNf+JcRS5wf02uwJ1TkD3WQWzlNxNR9N
	seUrN4e4EGOxtb3SGpuulLiHSGL5noSabwfXNUxyAt8hCVT+1aiyS23U/Qu5zXSHOm8xqd
	nEflpghE1dKnt92kLmy7m6T1QI3e8mI0EdUT+0MQnEAaosS2aD9Bqw45OPj/GQ==
Date: Thu, 18 Jul 2024 09:58:56 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, mturquette@baylibre.com,
 sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 3/3] arm64: dts: rockchip: fix the pcie refclock
 oscillator on Rock 5 ITX
In-Reply-To: <CANAwSgRZR8cM9qDD0Xn5ims4GX+PNMQ1+PEMBDQtZq2GxFd6Rw@mail.gmail.com>
References: <20240715110251.261844-1-heiko@sntech.de>
 <20240715110251.261844-4-heiko@sntech.de>
 <CANAwSgS_ZaEkt5-kKud9OwdN4za+xvW5SoBr34EmOdU2OQJWnw@mail.gmail.com>
 <8a16eb6a29a39719ba4e4c43bae3b6ec@manjaro.org>
 <CANAwSgRZR8cM9qDD0Xn5ims4GX+PNMQ1+PEMBDQtZq2GxFd6Rw@mail.gmail.com>
Message-ID: <72b84761ef93c1d4d6d61b16ef1bb1ce@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-07-18 09:52, Anand Moon wrote:
> On Thu, 18 Jul 2024 at 13:02, Dragan Simic <dsimic@manjaro.org> wrote:
>> On 2024-07-18 09:26, Anand Moon wrote:
>> > On Mon, 15 Jul 2024 at 16:35, Heiko Stuebner <heiko@sntech.de> wrote:
>> >>
>> >> The Rock 5 ITX uses two PCIe controllers to drive both a M.2 slot and
>> >> its
>> >> SATA controller with 2 lanes each. The supply for the refclk
>> >> oscillator is
>> >> the same that supplies the M.2 slot, but the SATA controller port is
>> >> supplied by a different rail.
>> >>
>> >> This leads to the effect that if the PCIe30x4 controller for the M.2
>> >> probes first, everything works normally. But if the PCIe30x2
>> >> controller
>> >> that is connected to the SATA controller probes first, it will hang on
>> >> the first DBI read as nothing will have enabled the refclock before.
>> >
>> > I just checked the rk3588-rock-5-itx.dts in the linux-next.
>> > You have not enabled sata0 and sata2, which might be the problem
>> > for the SATA controller not getting initialized.
>> 
>> Rock 5 ITX doesn't use RK5588's built-in SATA interfaces, so that's
>> fine.
>> Please have a look at the board schematic, it uses a separate PCI
>> Express
>> SATA controller for its four SATA ports.
>> 
> yes, But I am referring to sata node not enabled which enable
> the PHY_TYPE_SATA.
> 
> see rk3588-coolpi-cm5-evb.dts and rk3588-edgeble-neu6a-io.dtsi
> rk3588-quartzpro64.dts
> which have sata port on board.
> 
> &sata0 {
>         status = "okay";
> };

QuartzPro64, as an example, uses RK3588's built-in SATA interfaces,
so it enables sata0 in its board dts.  Rock 5 ITX doesn't do that,
as I already described.

