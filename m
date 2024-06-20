Return-Path: <linux-kernel+bounces-223113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F388C910DED
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 19:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54586B27E98
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 17:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974E71B3F06;
	Thu, 20 Jun 2024 16:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="pUdt3xI6"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CF31B3735;
	Thu, 20 Jun 2024 16:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718902795; cv=none; b=UXlbR/1cac9t+u2RrbW8FthX4z4byzfQp1m9axQfx4cCnMVhynm5S7NRR6JACQ2JRfke5eW1XvMCABUvst8eNRNScX2CGa178wbUidihIJYp0NOBAAXzfO8lYQRsVHFcC6V34PTCDChZUVbjC/b+tfXS7PG9Fz/dvU7YwtidrS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718902795; c=relaxed/simple;
	bh=BRG+sP7vlU9S0Ij+PyX4BGt/+GXAKzOhTP+8j7+zSLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mco7QZuL9o2oc26TrVQs0Di5PyruR2qptC0AAUx/vz9DvVKugK9Vm8rSoVxvuLvc690Xc0wk0vIokAlZdctSWHtSWolp8IL0EDTAk8nqSlgW6r0VUYUu+WuQuwfQ3uHc70dZl54qpk5uRxaZzcD9nwjF4sj7YG/tN2nUTPSJBdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=pUdt3xI6; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1718902780; x=1719507580; i=wahrenst@gmx.net;
	bh=VSq24EbJ74gt4mzsgZlLMeZYIybo9QSU6HsfTsY4ehs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pUdt3xI6V96TNv8FWBom+RXXUwSUql9w2JLvjtF6SeZyCvm1Gh+t1l3lnNXarJCc
	 pI+kD3rytnSWN8/ULKBkX4x4qvrVCR7A42rRzKVYTM1tzucs3XFe8HHn89w3IT2Ay
	 Rb2zjTW/UDwl0lvOzeFQUuVznsRfZ9MYD3rBA8RymGvrABiX6Fkc/gzMGJ7SVEBQM
	 fqQ9x2tbPfKl/El0Bk/iRByLJtYqaXQv+at1nuuI65y+H1BWvVltM9uZWYNA//3jO
	 b/5sopt2rlrqV1O2BLS59iV6Xy8tUFGLr2N9O19u4KbNy1EK5jBqfaNxKkrCYvOGG
	 n6n7tdYqY7S+oL+4Sw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTzf6-1ruSFS2yhO-00OHYa; Thu, 20
 Jun 2024 18:59:40 +0200
Message-ID: <a2f08c04-ff9c-4854-b5a6-a3b84e20b50c@gmx.net>
Date: Thu, 20 Jun 2024 18:59:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH] staging: vc04_services: vchiq_arm: Fix initialisation
 check
To: Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Umang Jain <umang.jain@ideasonboard.com>,
 linux-rpi-kernel@lists.infradead.org
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.org>, detule
 <ogjoneski@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE
 <linux-arm-kernel@lists.infradead.org>,
 STAGING SUBSYSTEM <linux-staging@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>
References: <20240614104339.3858830-1-kieran.bingham@ideasonboard.com>
 <37779db2-114c-4df6-97fd-2444bdad5529@gmx.net>
 <171836466631.2248009.16741779932900773222@ping.linuxembedded.co.uk>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <171836466631.2248009.16741779932900773222@ping.linuxembedded.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+wNmFXiH+5ZE6MG+T03/1HnnEwf5i0wgjf2gm9qTCMRMPCOz2oP
 cGP8uy9/P9I1JNRuMNltj5+ifvHkj0M+r9PD7mV+Vc0qzk7Jw9u4etBIkNQHzJCgfySzgnU
 o7koxn3CFaBbwtdHveDtJIzBXF17+sDAs3qBFMjbeKPo8+n+XRl2D/1bdHG9oQHBVR1W3d4
 jWg7RmtRMTbk15Cx96hVQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YON8xkvmoz0=;jnd5KYPzskkseD9u2qH2d1jv2Fq
 FaTcN3PNQ1j0LOXfEZjeEPMYFzm5UQQsYsZPaXOgg0bkt3mvB4Q0InrUY2C0JwqjgogiFZxkO
 Mppg7F61Co/4N2aXE3xeyN2ahh73e6EvYSEEJmQkECDSALMN3cqo7nZaS2w6k8CWGnO1YaIEC
 FUkgG3BetrmysjXSm2kAmHN9hZyFoTlXCuTornGJQ0PdwwYH/Cogf1/vU28z4JjfvPlIbR/DX
 7bIpFjDf0Axvw5ispFa3ky97i7D7FJvpowfLHjE0d6ZI8HuLM4O05pVu4kHpp4Hr1+JUsbNa0
 cFTuRIJ2FktwG6Oi4hATpnogdjusP/SS6FzN72zq4f3UopbsG49peYku57s23BgOYZ5X2YaY+
 anAyow0FcVKbfeTOGQWXTQGhB9rkAOAzEsgNjxYqD1hvuZ0ApHXcqNY+USCZcCwnoCkjkmB1u
 VySxM4tpTlTtxawDUnYxVky5z2m8kRlX4EzJgKlZMwGvBca0aEKFhhGqxLpPuA9VyNoOZ4XiX
 /pfoD+NXy/FH6++I6yqygeTilu2fRUddQseDw3wZDSTxW97iHPCQBe6MJ3ey1LF3xN+007Zp+
 XUqAvm0b64i4OeNcwVKACfYNZLDaRHK88XgtACva8h7OVR90UPDYdTrlmU6RDWimzaY9ex+8z
 MciL4rXz04oq7Bu+fOqBbwosg62ny85PLC7t9yJ1AA+Che2hfUQi7RNz1Z6hNiAaIS2ZryZTl
 vma119XkV1sSGGcryanQG2gBdQxoeMVU2GXTImwC3e0gejX27QXc1lmeuuYA5ffEEx9VE8+bW
 DKqpe5vfNMTsAG02dEPYiibgqmYWeqcWeBb7eSApcNbiM=

Hi Kieran,

Am 14.06.24 um 13:31 schrieb Kieran Bingham:
> Quoting Stefan Wahren (2024-06-14 12:00:38)
>> Hi Kieran,
>>
>> Am 14.06.24 um 12:43 schrieb Kieran Bingham:
>>> The vchiq_state used to be obtained through an accessor
>>> which would validate that the VCHIQ had been initialised
>>> correctly with the remote.
>>>
>>> In commit 42a2f6664e18 ("staging: vc04_services: Move global g_state t=
o
>>> vchiq_state") the global state was moved to the vchiq_mgnt structures
>>> stored as a vchiq instance specific context. This conversion removed t=
he
>>> helpers and instead replaced users of this helper with the assumption
>>> that the state is always available and the remote connected.
>>>
>>> Fix this broken assumption by re-introducing the logic that was lost
>>> during the conversion.
>>>
>>> Fixes: 42a2f6664e18 ("staging: vc04_services: Move global g_state to v=
chiq_state")
>>> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
>>> ---
>>> v2:
>>>    - No change, just resend
>> what happen to my comments for the first version?
> Err ... i missed them ... let me go back and look!
sorry for pestering, but could you please send v3 of the fix? I want to
rebase my cleanup series on top of that, because bisecting vchiq is
currently no fun.

Thanks
Stefan
>
> --
> Kieran


