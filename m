Return-Path: <linux-kernel+bounces-335718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3769097E997
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 12:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68C051C217E7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 10:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B5A196DA4;
	Mon, 23 Sep 2024 10:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="XslPyD/2"
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215AC19580F;
	Mon, 23 Sep 2024 10:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.3.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727086175; cv=none; b=Id25fmIQsRTPTt/tT947Jx1vOqP8lMRz814P3865pYhEv5qs6SzryNiLv3L/w7U64om9FepsvFwJK0ydIiY8Z8hrEUzHSp1v4AZahz5laG/yKrrRXKh8HUdmngMG2LcURcAEZPKHniwW3GQ1nEGzQ5haKHIAmWFYN7/qXFXLnCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727086175; c=relaxed/simple;
	bh=QZ3pAoHrGvUQCCcPlsz7aLXmCdd7EUz+OWY1xzniUFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gz0ElC8JBWI6y2jVjKBjMwRWjiJinekO52owHADPpyD49d/yqHXScy04mPXjcbaWa5oTLPTcv3a/VII3imiWF4Obq1R5YCdGaPSn0J4N5lZ/BXBOj9h9wfMbcLGLGk0pt6i3WpFvQS9wJ2tNEJ0BfRwryTmmDrnJrC6tH5Sum2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com; spf=pass smtp.mailfrom=ysoft.com; dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b=XslPyD/2; arc=none smtp.client-ip=81.19.3.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ysoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
	s=20160406-ysoft-com; t=1727086166;
	bh=mqxC8Twz5bhAEBeZd64fyOAa9Ptp6JX1NANnvh+5f6A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XslPyD/262cs7tuq3XgQDQY8bwCA9znDEFndO0lWbD9VqVxHisyHuW8PPfJU0b5Hw
	 OKLM8+WRdFGhPhD74YYn5UqnDY+ZdFNMkEgpN1eyl188K2EwVNacF9ciYbFgI52gJQ
	 z7xa8sJNQ6AU05DTunnmJI4rJEgxPM5knOff4WsE=
Received: from [10.1.8.111] (unknown [10.1.8.111])
	by uho.ysoft.cz (Postfix) with ESMTP id F1063A025E;
	Mon, 23 Sep 2024 12:09:25 +0200 (CEST)
Message-ID: <8f054dbe-6f58-4c93-b5db-1c67cb310a5f@ysoft.com>
Date: Mon, 23 Sep 2024 12:09:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] arm64: dts: imx: Add imx8mp-iota2-lumpy board
To: Fabio Estevam <festevam@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Shawn Guo <shawnguo@kernel.org>, Petr Benes <petr.benes@ysoft.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Herburger <gregor.herburger@ew.tq-group.com>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>,
 Michael Walle <mwalle@kernel.org>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20240920080154.1595808-1-michal.vokac@ysoft.com>
 <20240920080154.1595808-3-michal.vokac@ysoft.com>
 <CAOMZO5BrmuWdiEo6xi8ChT01jfLMaLAb88iUhS1kt6qqr_h7pQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
In-Reply-To: <CAOMZO5BrmuWdiEo6xi8ChT01jfLMaLAb88iUhS1kt6qqr_h7pQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21. 09. 24 14:24, Fabio Estevam wrote:
> Hi Michal,
> 
> On Fri, Sep 20, 2024 at 5:02 AM Michal Vokáč <michal.vokac@ysoft.com> wrote:
> 
>> +&usb_dwc3_1 {
>> +       dr_mode = "host";
>> +       pinctrl-names = "default";
> 
> Per Rob's robot message, this pinctrl-names entry should be removed.

Thanks a lot Fabio. I could not really figure out what is wrong and
thought that all the three warnings are issues of the imx8mp.dtsi.
Will be fixed in v3.

Michal

