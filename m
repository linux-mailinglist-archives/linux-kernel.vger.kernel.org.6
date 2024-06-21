Return-Path: <linux-kernel+bounces-224014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 685F0911BF9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11B4A1F24E29
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 06:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD0715665D;
	Fri, 21 Jun 2024 06:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="g0CdWj5l"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD28D12D771;
	Fri, 21 Jun 2024 06:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718952115; cv=none; b=AloaONmXz4Q5xyDCeTdKj9+aDbbLYviqdHjtuGCNAlTwYT95LqthXq7lkY+cUMyShgUYXBP2wBq1i5wPLFSc48vLRpGOoQA1IGOrw9YGbB1u5OLZkmVh10UOsVctk2zAduMA7FLdRmYDg0XAA1R1NUPSan58eQuVkTn/8C1Ne1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718952115; c=relaxed/simple;
	bh=VUkaSSu+ECaDnsfMkRJ9SaqPBCmF4mpMSRv73bTS0Ss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mJZOQnzpKb6BkblQHduEipT/IBbbdVhXE2I1El5zqoKuY8b1bQlA299YE1MHojpOjua/s8qdIbVNytMOodCTTOFNdT209bektG2ejNZ+8QnlWVqdt+TsVt4gf7k0lcGpA5GU3+8/J5CTBCax/WKufq6VypJmQlQGZTyXmxSy1qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=g0CdWj5l; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1718952092; x=1719556892; i=wahrenst@gmx.net;
	bh=VUkaSSu+ECaDnsfMkRJ9SaqPBCmF4mpMSRv73bTS0Ss=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=g0CdWj5lavn6LORQY1hFb6H4A1ofC63qY80ugDYcpGFhp9EZn0zK5laIydIyPpOY
	 2acOpyL52P62MG5yDc3mnQroMO2EOr9B1Vp4nZbKV2Xrllax5wm8dCVv7F+SOu9y8
	 lWoMTE2oPzr7gABhQ7HPpoPnt5NH4R+t3X0NEFGyPlAngonMrx/CHKrRm2+vWUgyL
	 JQLR3Km1aH1LTVrzrIW6FfucACgGHMLhxNDx54X8hhMknxkvPiZNzbCp+LskoZg3m
	 D0Tw8/dTc7rp5BG09iaynk1yB23Qm4zRRZzv77ECdfv+oPJhrKBB/Ffe9uR6e6iNc
	 xNJWXmFTgWYa6H+LJw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mi2Nv-1spE0j0crZ-00fe7Q; Fri, 21
 Jun 2024 08:41:32 +0200
Message-ID: <c52b1019-c287-496f-add2-88904998e10a@gmx.net>
Date: Fri, 21 Jun 2024 08:41:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] staging: vc04_services: vchiq_arm: Fix initialisation
 check
To: Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Umang Jain <umang.jain@ideasonboard.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 linux-rpi-kernel@lists.infradead.org
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Yang Li <yang.lee@linux.alibaba.com>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>
References: <20240620221046.2731704-1-kieran.bingham@ideasonboard.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240620221046.2731704-1-kieran.bingham@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Wpd9KkIeXygl/nb32+4UUSqSYwdlgtvNOFmQsRZAf0Z1X33jVGz
 MFD16gpFHutXkgJ38a5tEUVrG9wWWVJ5wJPdh4c1KJX4G/TYQmKohSKxOvMsl8m9jYeNSFw
 iHM5p+/Req66TGjXGNwuVDI96WmPi8VZB5ASDjFVC9/2q9b00F/WxbRfX56Z4rrKNo/rJMt
 YCECaXf6cY1Z8Dh7NGwVQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9PT+CJB2Xy4=;fzACF8lnaW4XVn6UB9m69cikxw6
 FK2ojhx7tVz9U3+axixBDWqB8ccRdk2c2VA6ZzV0Lzc7Xl15mV4liI5+WF65iEKNKJy2Tmkh2
 1Ol2Zx2CXBJM7/PP+kgrzvWx0A6AMdlbQgC32JQVxLrI7SzpJ+F+p4tXfwBhjFI2ByBoh+Vm7
 yhYZ7JWcod6PAtWxj7ttjRI+nFgwzOhs2voouf3fjExkcWFw8gTbSL4dn3dInlNxc0gA+MiTl
 s3SUDPXYTpyOkNdWfW5sZfTHGes0SvlItGEBzL5McUm57wAG/1s7hkNAfOOSzEiuaL05UsNHf
 95MJqw58XLlxe+7Njmo0CoemPCG6fCVT/TdBuKFzhOEd4WXcSC0QwUNZ8gMrqOKaKv0OYKBOF
 mRBTLJaSpkEiJQCC61xYTqjKcIr+aRfyZYbFwINNUFCDeuISz43oamWWms0NyGTVccj8mBuvz
 bdgtrn+nDilCzaReCRYequEOGp6t5KKcwEvPN8BMDR87+DLCbHB7yDdQtYzdoi6xZS4aIdSOK
 007dow8y2GIfhy3ryD06J0j+yKTX7ET7MlgcORRQwPI87ql2qifFPLAz+mlE5ZQiFsH+H53zt
 C9QtLdsKBWLjIH9dgagv6kSGVLRfMtrVuoJwCP6kOe6pk/UEu0qsufkOi8kypifw/D8pMVuX+
 jIEUxStvQBdODI/LySN1eKvwS6D5hRdVlNvpMEwUew4wdKfFFM8XArYPknoP12Gi1E+plq4Kx
 Y76EmOUUY0XLSTwJlUAxh9RnCkgPeKAOqRXOEAl5EG9O5UZoMIDNNsFcjtlDFNCjzZThelAuo
 plgGVibmNI7a+KkvLuphJKB6Zjd3nVN7Xl9dcqzg+6+vY=

Am 21.06.24 um 00:10 schrieb Kieran Bingham:
> The vchiq_state used to be obtained through an accessor which would
> validate that the VCHIQ had been initialised correctly with the remote,
> or return a null state.
>
> In commit 42a2f6664e18 ("staging: vc04_services: Move global g_state to
> vchiq_state") the global state was moved to the vchiq_mgnt structures
> stored as a vchiq instance specific context. This conversion removed the
> helpers and instead replaced users of this helper with the assumption
> that the state is always available and the remote connected.
>
> The conversion does ensure that the state is always available, so some
> remaining state null pointer checks that remain are unnecessary, but the
> assumption that the remote is present and initialised is incorrect.
>
> Fix this broken assumption by re-introducing the logic that was lost
> during the conversion.
>
> Fixes: 42a2f6664e18 ("staging: vc04_services: Move global g_state to vchiq_state")
> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
>

Reviewed-by: Stefan Wahren <wahrenst@gmx.net>

Thanks

