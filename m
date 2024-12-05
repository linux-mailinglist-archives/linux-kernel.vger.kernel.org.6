Return-Path: <linux-kernel+bounces-432900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C4B9E51AD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 062B516682C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A131A1D5ACD;
	Thu,  5 Dec 2024 09:47:47 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8370D1DA10B
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 09:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733392067; cv=none; b=ijAgTRVSfcifkdh+02X+HRx6ksNa0QDs5Og1Ob8HNjiAxrHfccA5LDwsy7D79LzcFg9k5cI1tCKs4KeBsr9B7bj2FoitndtmdLJkFO2SYHsZ96MHd1+SaFfCzv6/h+lxBFaPJwAHom7xTpyn2/vgwpWwkeRaOi6cKMpW+Ffcb1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733392067; c=relaxed/simple;
	bh=3J8TfsVvqWpIFDLFMwzu/nm3tSmhMuAi/Hx+Zwqs0Uk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PrMqCwZ2WYuivljTaAtPOi1042VSwzKI8DuJPLtfIDoWvhog/SbO1fiPC6Tz0OdTecGNYt4GYNi7Um3dtuDaGjFUWFCpbhfoKvnXwAHcs+TirM3nB2N/A2rD1AASkWuCTa4e5wGY9H+6B5t0b8EMv8DuYC5eC3/oaNhjNXuYe2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f03ca316b2ed11efa216b1d71e6e1362-20241205
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:897a85cf-7c1f-43f9-a29b-bbc16d0b098e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:22e53e67435ffa48285b85064d3d96ed,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM:-3,
	IP:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:
	0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: f03ca316b2ed11efa216b1d71e6e1362-20241205
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1347420235; Thu, 05 Dec 2024 17:47:27 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id BBB5E16002081;
	Thu,  5 Dec 2024 17:47:27 +0800 (CST)
X-ns-mid: postfix-675176AF-6394841546
Received: from [10.42.116.241] (unknown [10.42.116.241])
	by node4.com.cn (NSMail) with ESMTPA id 61C9116002081;
	Thu,  5 Dec 2024 09:47:27 +0000 (UTC)
Message-ID: <2bf7a89c-02d0-47e6-890b-10513e51a940@kylinos.cn>
Date: Thu, 5 Dec 2024 17:47:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [PATCH] TEST
To: Aleksandr Nogikh <nogikh@google.com>
Cc: syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <6751189a.050a0220.17bd51.0084.GAE@google.com>
 <f7ea7d2ea6efebf66a6c5a27409ac76e404c7241.1733387703.git.xiaopei01@kylinos.cn>
 <CANp29Y7kk8TqW9a7jP1hjH+2OxvObHHYz9vEVTjO0Ud75MkVNg@mail.gmail.com>
Content-Language: en-US
From: Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <CANp29Y7kk8TqW9a7jP1hjH+2OxvObHHYz9vEVTjO0Ud75MkVNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2024/12/5 16:50, Aleksandr Nogikh =E5=86=99=E9=81=93:
> Hi Pei,
>=20
> Please note that if you want syzbot to test your patch, you need to
> explicitly tell it about that:
>=20
> https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-=
patches
>=20
Thank you for your help!

