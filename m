Return-Path: <linux-kernel+bounces-264222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A34FD93E058
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 19:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE9D02821AD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 17:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39367186E4B;
	Sat, 27 Jul 2024 17:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="ViSWKFfs"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13621B86E0;
	Sat, 27 Jul 2024 17:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722101179; cv=none; b=j62Lcnlz/BCw8SyiaHdtpy2igTYPCDY2Ojl7JmkYZj8rUj7LRPK/beCUi5Bjvy8GpZFBL6UbnFBgRTPX9/B4PyUnh9N/BWxOM7PU8r0Yth9j3WP3hIyXVxNsKqvHKmHkw90QtqxdwKYhQxwfmNnRj8Gvh16ObDmj6JLYuCMgIe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722101179; c=relaxed/simple;
	bh=0JUr3fUYlefWhft141VQNfADwU7JSh8bF/I57R0uKBs=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=AkB41En9gy98DuvhZ5jGHTUxfjQJvf43XEubz7L7tP6V1rkfimI8xENFaoibK57gB8RzAvHmFNYZEA+d6Ra5ievLZDlM6x0i8a3zxbHPOISZUv7s/yBRw2OfDw3EVZIXFJevBaFYuOT044wcX8kN8KN8NVjlWUUiJeR0DBayV7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=ViSWKFfs; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1722101174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W0xWla7GajGgE12FYJTA3d2+hQz1cIEdi3VEmQzhsqU=;
	b=ViSWKFfsWDciK9XUpUBuKYVTxLx9sxSn8tut/Fb7rTZ8nc+lDO0Cqt+IEXrLa9ANFnOnwR
	hZZDDRyhK5TpO9LtPOqwUmvjUnJ30p0bN0dA7WKoQmlqxpCcx8x/3FW1uyw9UxWbNEUy/R
	YP3kkWlSb5/TqYFmpfv054kaAz7YxVF8HLwCkJ2cjVCa8kbxensjSURX6CRnLWB9b8MOkr
	qNjBK+CZuZ8cFirrNd3DaZjYAbIP/QQlp2127HvV5/PAYVlt6xMCJRCfQC1WDyQhY9+V/b
	vgEMR+hkTrLuqKxlZHOHZ10Hpl+tOOk1q7VNuOuPiCA+Ab4oFCDfd/hCYxx9cQ==
Date: Sat, 27 Jul 2024 19:26:14 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, mturquette@baylibre.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: clocks: add binding for
 voltage-controlled-oscillators
In-Reply-To: <00f9f4b8722d97b1c6fcec27d53bc06d.sboyd@kernel.org>
References: <20240715110251.261844-1-heiko@sntech.de>
 <20240715110251.261844-2-heiko@sntech.de>
 <20240716-deceiving-saucy-851fb2303c1f@spud> <3178118.zE8UqtGg2D@diego>
 <20240718-prozac-specks-6b5fd8b83e3e@spud>
 <00f9f4b8722d97b1c6fcec27d53bc06d.sboyd@kernel.org>
Message-ID: <1f6f4cd84b06a95881093772d5b799ef@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Stephen,

On 2024-07-27 00:21, Stephen Boyd wrote:
> Quoting Conor Dooley (2024-07-18 08:59:50)
>> 
>> FWIW, I wouldn't classify this as device-specific. "enable-gpios" and
>> "vdd-supply" are pretty generic and I think the latter is missing from
>> the vast majority of real* "fixed-clocks". I would expect that devices
>> where the datasheet would call
>> 
>> * Real because there's plenty of "fixed-clocks" (both in and out of 
>> tree)
>> that are used to work around the lack of a clock-controller driver for 
>> an
>> SoC.
> 
> I agree!
> 
>> > I think generic power-sequences
>> >   were the topic back then, though that might have changed over time?
>> > - There are places that describe "fixed-clock" as
>> >   "basic fixed-rate clock that cannot gate" [1]
>> 
>> I think that that is something that could be changed, it's "just" a
>> comment in some code! Sounds like Stephen disagrees though :)
> 
> It's more about making a clear break from the fixed-clock binding so
> that the extra properties are required.
>> 
>> > - Stephen also suggested a separate binding [2]
>> 
>> I liked your "gated-oscillator" suggestion in another reply, but
>> "gated-fixed-clock" might be a better "thematic" fit since this is a
>> special case of fixed-clocks?
> 
> It looks to me like we've arrived at the hardest problem in computer
> science, i.e. naming. Any of these names is fine. I'd look to see what
> those parts on mouser are called and use that to drive the compatible
> name decision if you can't decide. The description section in the
> binding could be verbose and link to some parts/pdfs if that helps too.
> In the past I've seen EEs call these things clock buffers. I'm not a
> classically trained EE myself but it usually helps to use similar names
> from the schematic in DT because DT authors are sorta translating
> schematics to DT.

Please note that the hardware components modeled by these DT bindings
are definitely not clock buffers.  Those are simply clock generators,
which can be gated, hense the proposal to use "gated-fixed-clock".

If we were to additionally model Aurasemi AU5426 or Diodes PI6C557 into
new DT bindings and into the board dts file(s), which I'd support 
because
of accuracy, those should actually be called "clock-buffer".

