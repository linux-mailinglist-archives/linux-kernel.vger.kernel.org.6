Return-Path: <linux-kernel+bounces-201361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDBD8FBD83
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 22:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46BEB28434F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 20:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E54A14B97D;
	Tue,  4 Jun 2024 20:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="AyEZbuQE"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB0813F451;
	Tue,  4 Jun 2024 20:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717534116; cv=none; b=qiRWmWkkA610738OHR3vsVmft/lpl0TFfun0J0LC9aWIA1xehirgzfG3n6217tosOj03mHdw57IXVQlYiibbEVZ98mfNzZQbKyUdlWsxGgiTV7afpA9oT6PrVra/pJDa3ECv1ikG7K/2z6LJpXxsWYXeCDR0qniJczNUQG43yLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717534116; c=relaxed/simple;
	bh=24z1rBJP/t4A6eeiNMz6cumSnbPF5JflnPk3fIfkeYM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=LCw2Yj4Fo4UMm5BCEXZymy6RoGQ2PsptCZRHb3B1alcZ2pzdLUdcR5aTSNw7QwYx4Tym4AgqlnUxuOiWhjF01+Ks2VpM7QyVqkSEctKPY86ioLd9HqUW6wMlkxEprY8dTAaY4DpHqvyp0ri08LooAuFAsWYtRXpJCoYiC42VOkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=AyEZbuQE; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1717534112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jaTzlawGlDcYRhQAm+R1AsWpCyayK2cAnVa+Y0OsHVQ=;
	b=AyEZbuQEG/qqS8hCg4QaBIOxBX5BDnlwIu08AMxosoc84FDiVVV5NnCCTRWyhFB4zo5xVV
	Mqf8T7Qr9+QUghlk4yVtaLV0HE9dLTRffsJyizkktmF01hfJTm8DXRaX92E2WANTcuw9qC
	w4A4pFK81Zc09M++1RkPeePFtqjojo5/EVcinZZBjENohmQv3PByt+ZdvBqTT4sIw3l9XQ
	0xixHMlzRPKwYzIJHUZ5J9El7sfvISr3oEKry2exmbn/eKp2SLdv/reoa0IGUazY4NSGwV
	ry6MW+Ao7vnlq9nEmfX+fJgg4lbEia7kzrfWlCJ4aCEfSCWSNDe2v0vQO34A5A==
Date: Tue, 04 Jun 2024 22:48:30 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Alexey Charkov <alchark@gmail.com>
Cc: linux-rockchip@lists.infradead.org, heiko@sntech.de,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 robh+dt@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org, quentin.schulz@cherry.de, wens@kernel.org,
 daniel.lezcano@linaro.org, didi.debian@cknow.org,
 krzysztof.kozlowski+dt@linaro.org, viresh.kumar@linaro.org
Subject: Re: [RFC PATCH] arm64: dts: rockchip: Make preparations for
 per-RK3588-variant OPPs
In-Reply-To: <82db817a908b761d8c3d73ea04714314@manjaro.org>
References: <673dcf47596e7bc8ba065034e339bb1bbf9cdcb0.1716948159.git.dsimic@manjaro.org>
 <CABjd4YxD41DEkBCZfkznLboEY9ZVOfTCLcj4S_kkcsVswbANyQ@mail.gmail.com>
 <8f8623e29a479c4108141302e708dc3b@manjaro.org>
 <CABjd4Yy4RMg+6-4ygV0MSwJj5LReY-ymbctq4PPfVZ6L+c1tsw@mail.gmail.com>
 <166cc4e46f31644a50306625b2ab18a6@manjaro.org>
 <CABjd4YzDNQa45=KC_t0xnTDrH+g-oUrcpgP55oOj7JcAuu7uFw@mail.gmail.com>
 <82db817a908b761d8c3d73ea04714314@manjaro.org>
Message-ID: <75563ad3f6bf6b6c8b151ab0cc26b490@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Alexey,

On 2024-05-30 21:31, Dragan Simic wrote:
> I'm sorry for my delayed response, had some "IRL stuff" to take care 
> of.

[...]

> On 2024-05-29 16:05, Alexey Charkov wrote:
>> The problem I have with -common is that there are several layers of
>> "common" even among just the three of these chip revisions, and a
>> clear inheritance hierarchy between them (i.e. RK3588j and RK3588 also
>> have a sizeable chunk of their IP blocks that is "common" between
>> these two variants, in addition to those shared among all three
>> variants)
> 
> Hmm, I see, that's a rather valid concern.  How about using "-base"
> for what I called "-common", and "-extra" for what I called "-fullfat",
> for the lack of a better term?  Using "-extra" takes inspiration from
> the way Linux distribution package repositories are commonly named, so
> it should be rather familiar to nearly everyone.
> 
> Also, "-base" and "-extra" are rather short, so their shortness would
> also make them stand out in the directory listing as something that 
> isn't
> just another board .dts or .dtsi file, which can only help.

[...]

Since there were no complaints, I'll move forward with sending a "real"
patch that uses "-base" and "-extra".

