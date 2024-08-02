Return-Path: <linux-kernel+bounces-272866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 524DF946206
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D481282229
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4D513635E;
	Fri,  2 Aug 2024 16:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="uS7onl47"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0958F16BE11;
	Fri,  2 Aug 2024 16:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722617369; cv=none; b=mHpCQZ50LcuuVAtN6dKVpnUsoT6Nf+pPnPIYAUgmsdsEBLyz7kc+Dc9HvuHOtS7i1Yk+FmZPC+lLXkQdLyeo7Jz6B6Z7vl9bLk5LVYw2R9V5WCEgKZh/ES7uq5Qzbu1qZ703U47BKl4aQMysw+nptKkkxJR5s24Ayl3UpAzyqVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722617369; c=relaxed/simple;
	bh=MYX6RpPC9328x3gSz3cen8uvUKQCdBkMJbhYZwYyUac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gkgGulMvbJPTuxVWiJ4+Zme3BxfVSlFJoMviPuQbeYCPBlV2ilnZpMxhC2AJna8no4kHMHXVhLhkvQubfreN5OQ+HszvQZ90vDlXg4uLJ/RpkLsXQHCglBG/Kk32+Ngid8Y7HKSh+LpgHB3ObkRJs4BScyRVOpmYYk0rHx1LDrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=uS7onl47; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1722617353; x=1723222153; i=wahrenst@gmx.net;
	bh=MYX6RpPC9328x3gSz3cen8uvUKQCdBkMJbhYZwYyUac=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=uS7onl477NLKBGCnNPEucHTW8USXN6T/Ib/Bg8TNQFejL1R3oLxJH9DQnaHRGSeO
	 uepXSkhkyDLvsJUwzIW2NTtOrOdL3le4ni15nERHs3VUM/yrH7B7Cv6qvJ2M6C1hr
	 bEc62tj+TtuLGU5A3RsjSP00BmW5W2nIQefr0o+bfYk8jjs70CLipN76wXw+5iJ5l
	 N3uH5B0FqED20cG8XlUhU9pm5rgjCyYbf3rgl+yC7IdInApLbt8VHq3xVavP9igri
	 CnE3cgCPoYwWWCoHavnFgVD29HAVyfdQfQ6tAX/9dZKNA6VFRKIRZ5peTiSNw/ue8
	 qBtRDkLKskuk+yKw3A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7R1J-1sAbED3H3N-00tVGu; Fri, 02
 Aug 2024 18:49:12 +0200
Message-ID: <4114a4db-6ecf-439e-af45-47b24612fea8@gmx.net>
Date: Fri, 2 Aug 2024 18:49:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] arm64: dts: imx93: add lpi2c1 and child node
To: Frank Li <Frank.li@nxp.com>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240801160915.2505610-1-Frank.Li@nxp.com>
 <944715e8-e91e-46dd-a053-7e00a17dea72@kernel.org>
 <Zqztwh3yghN8Drnj@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <Zqztwh3yghN8Drnj@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LeHRWLSQp2cexdwIEAUp2pVcYtlib7hp1pNc8Z3gqzgwdlEyg6q
 qgyQpU0HykzesG+OPfeMMn8v/ssdIuOZgez4ywZz590pWgFrH7qOSMgILTYD2fjRyfmCVGF
 KC2yASMjMPA6kD/46iHHCp6ZzeUrL10ZBhF3CtzC9CT9fsQAU5G5TUdTiSOhweo5HEQN+5C
 uHU1HSXoYOi88NpLPrNGw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PQXslPS15dU=;VTqn4z72wxRK4wipEq2Avt87JH4
 zJnS/7+1nnv/0Nt/movrkRQigA+F7Ygj4LViK0KR2Kzj6fTL80/esOFnern5KAJHV9DdHus8w
 GRXPfvHuK6UTexTxVOE+Teex4G+sOdCqDj/39Mh+yA5NLXHYJgZp+qnQ98FHWgnSrIsfeT+mF
 TsIouayk461A5cLul+nq7vr3eCBNYIMIhcr/jccYN+ynUKUgjiQtEbXElcax3CjDdW/HbyRlr
 vRCmdRvle3iKsV1uvXWsqhk2FDxUzAMJpzmMcVbTSU3nMM1FH1d/7TXv5DIRGEJHO4iw0tpM0
 wGmrQz6dSQnyjlvjzpNojBUMLZ8R8OMi18j2yNsjrgrwKyeyAxENmNjx4j3b6tXW5VNMVTdE8
 abBERCT593Ay6JkooFvHyoXCa1k8LfLAYfm3i4koIEDHorfDTXRlihFMUlpbsZ+MpM5k8+pAf
 fQzSItTMmxLEWjdsEFeH3xJl+w6/b+rKevRnMi8TJrKWs142fHiWsiBxQd6BmQ9a5MMZpYpU2
 /tCrEdjzuLUalxDBc2eMXhUXsopYZoLs9h24ueEiJCb6y5mnovc3ng08mC7rIMVyChrOpb2Sd
 kpJidTf2FLunkJgm610TzzwCxcY5IzETlWdfmljKiPgFLgEZup/F0OLFDpMzCoTLQTaipFhG3
 CGd2hPfb2ZinlGmoBweoFjCCjAnbuVQP2N/siuRm3GiwQwJde5o2DtHWv4oTsD75h/PkLLCjq
 qJaLxKsLWuY5eIkmYCQjAVZWp+Usck2EaGja72hVigYBGvp1AsHAx/8/GgUbKD/SDmDAhC6tX
 6XBg3mJ8JQOyKYvTDnIP7OVw==

Am 02.08.24 um 16:31 schrieb Frank Li:
> On Fri, Aug 02, 2024 at 09:25:54AM +0200, Krzysztof Kozlowski wrote:
>> On 01/08/2024 18:09, Frank Li wrote:
>>> From: Clark Wang <xiaoning.wang@nxp.com>
>>>
>>> Add lpi2c1 and child node for imx93-11x11-evk board.
>> Why? What for? What are these? We see all this from the diff, so commit
>> msg should explain why and what do you want to achieve.
> I really don't know how to explain why/what for these straing forward
> thing, hardware board has such component, just add it dts file.
The i.MX93 11x11 EVK has a ST LSM6DSO connected to I2C, which a is
6-axis IMU (inertial measurement unit =3D accelerometer & gyroscope). So
add the missing parts to the DTS file.

