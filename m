Return-Path: <linux-kernel+bounces-214823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3830E908A9A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 13:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BF0C1C22E0F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 11:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EAD194A7F;
	Fri, 14 Jun 2024 11:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="bJMLp8ha"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D665312EBCC;
	Fri, 14 Jun 2024 11:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718362853; cv=none; b=Qu3ESEd00ybi6ma267DoLXkCCierzlugTwFe1QsGLe852nGX4Uij7zDJ89w1U11QFyP9qyScK/89xgkVEN9egHBh5HKczWqQC5OlLH0pa7KstLnB/lsdt+3hCws1MQ6ppGz8djxGa68ARBen/vNZKTLwQxjkazTxdQA05OrekI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718362853; c=relaxed/simple;
	bh=XbAgwgfKrA7Fbt5dPXgvHgaiUcmTbpf4DGqUKdg6Hzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mdEGT5tgnjBNMWngrdZHlUw76uO1i/qYKo5SO1tF8coZbP7Z+4ifhJ2jgByNt5tNrL1v2sXAJslE2Z1QJCQlUdfGBaL50WpLHl75EY6grACx/E/tYv+RC0/Qq0QFdw+WPmxYF2WPFEFgEFSGZh4DbMisXtGakQPT2mIBhCBOj58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=bJMLp8ha; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1718362839; x=1718967639; i=wahrenst@gmx.net;
	bh=tsz1UYM9GCAJOYfb2z2u9+uF06KESrhLFbU1n5w8GA8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bJMLp8haWpzTtwKAkaSYNa73UTeWzIdP5ASkK++UDVDl2GdYEvBGo4Tyx4HOtxIz
	 n+6F3mgIJ/MXl4HpkuzwVUs0L7RKZNZlS9CK/e5x5mP3e9kFP36khivj1qzjWQ5uO
	 9adSWVmU83wYlcQXqinEmdqSDksBRHOnUCfDPdRbyvb0k3w1gpKa1rfM8LkyPQn5K
	 AqyxaMIJypaXmgCHSkY8t/Gl/YhzdvZvGB5Ewo0Gc9UGEWisWM39aX8fzbVmhSa8b
	 hxuyB6S2Pdeh3QhfI5Ck2o7XBvjdkuFlmCrE0K0lYtMmT+9apzA01vi+wtNbEHfkb
	 OkEWGKXrNuQucXZBOg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4s4r-1sHnou0eYh-000WGl; Fri, 14
 Jun 2024 13:00:39 +0200
Message-ID: <37779db2-114c-4df6-97fd-2444bdad5529@gmx.net>
Date: Fri, 14 Jun 2024 13:00:38 +0200
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
 Umang Jain <umang.jain@ideasonboard.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 linux-rpi-kernel@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.org>, detule
 <ogjoneski@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>
References: <20240614104339.3858830-1-kieran.bingham@ideasonboard.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240614104339.3858830-1-kieran.bingham@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:KAYiUdEMFtRV5B/1HvoRtV3BH4huqF3b3eInnG6zPq/J1rkmPZn
 pSHPJsDQCChJklroy9utSnUdaEQkSDliua6OXwqI6o/EEx6oSu0jvT1bHUYA6VtHNO4E1au
 UK3PMCpjN7YH+MQgZ1cx1hv+7d/e0rsATF4IQ5196Xq6kYqKq3qoyq4iVRk1157EIHkylGr
 NXR+5yaG9lho26GcrNqHQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:occl8Cm/CtM=;YElQUL7i3ZG/PImyL2wJ/77mUok
 k/F+SGxzbvFf6/oJ2rRQeJB9fFFtppZ9s+2mmp0BFJw1jS9VMXxEYCmaUNWX4QpN4gesiC5Mm
 p0HzMDaDRUVhLV4Dtf31Bxtkvk1LqFVmLvShYWdX4yYrLgLWOI6OEyJ7K5dw9QDm/MuJzEUrL
 W7RjjkdUEty5cxu5DnArW//TcAGv07FVoJB7kH0GSfQQiWVFADcfqVdIILY498CmK1PLotwyM
 bPEBIfbLHtiHbN1hS+UjdGmjboPnamGQ4bdzE+lA7oLHSrGFepImn09pXcwnrL14ZyzEhw8Sk
 P5hNmGJxRtv6PGGhrdrO8YjphzCXYj/RAsIciN6jW26yo2ozeJYrC2/++DLy2QWS5Nqvl7Qv9
 RAsa8Mr4tXYcUImPM99I340nEQM7HWriNhS95s5onfekgvOzuHymp+FyYW5vsmK6G2k3MAsZZ
 Ii9diRRyDm82ZXYiRRFCnUhD8v/4zWnxgTMTqvi71ogylPpILCS+A5233t+7nXvsprWdXS5qE
 N1qxnnmlwDzt5ZWPF94Crh2FhJCTtoSOttDyyoiN2TCxbxDHg3Rz7idpDz+r/bfQdCQWccvjZ
 kNlxwUYc8uRrfGp8O4xYTgb/xfOY/vWZlQ8WPVUQ5hC9LIdHIg+UrxPa71jcmAoeGx5DVuRk0
 PHy7PQiZEEbE+KhekwTvGHbdH/vLQc7wokCdbyFVo/ShCI7xfstSCPX+/TJelBegA8CqWn+pL
 OLDrEFHEZMWwq4wKNhUfwVQeEmzllLH+c4PF5ZzDKG/Ml7GiAVaqN22GdvLqvnzJU49kDoCHN
 o+MRHucJ908jwfAvbcySkMe38vOJZ9EBbdxEbpHfPPuAI=

Hi Kieran,

Am 14.06.24 um 12:43 schrieb Kieran Bingham:
> The vchiq_state used to be obtained through an accessor
> which would validate that the VCHIQ had been initialised
> correctly with the remote.
>
> In commit 42a2f6664e18 ("staging: vc04_services: Move global g_state to
> vchiq_state") the global state was moved to the vchiq_mgnt structures
> stored as a vchiq instance specific context. This conversion removed the
> helpers and instead replaced users of this helper with the assumption
> that the state is always available and the remote connected.
>
> Fix this broken assumption by re-introducing the logic that was lost
> during the conversion.
>
> Fixes: 42a2f6664e18 ("staging: vc04_services: Move global g_state to vchiq_state")
> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> ---
> v2:
>   - No change, just resend
what happen to my comments for the first version?

