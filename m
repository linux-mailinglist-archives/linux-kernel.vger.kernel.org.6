Return-Path: <linux-kernel+bounces-391625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B319B8977
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 03:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 524AB1C2176F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 02:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F004D13A261;
	Fri,  1 Nov 2024 02:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="b3ZI95dF"
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839894595B;
	Fri,  1 Nov 2024 02:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730429055; cv=none; b=aAMfUnXUiYuLz/0qBJnB+UVUagDhShm3PADF16PP6WfdsqB4yMzvV1H+abdQkioEfFPwEApqUImGsaZ5wFV6K5Oeh3WFrWlwk0JjrvnQktYDo2y9Z02HZa8aRRnpe3G7VpHJq8r7yMbI9Ox9cVLZ6PbvUSd8sOnfwW1ZVFZTJug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730429055; c=relaxed/simple;
	bh=45sj4NJAJZtRePSx0lOsNGqUtcFD/voHAcNitTeIQu8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fztHaK4WHM/eEt1i0s8rpW4nBgDy+8B/MZaksYWx0cqLMgNwxWbed3QHQRAQngwc7Oanzpl2JbGr97fjPdSTbmEp+XlLRHboOQ645FglxkA/3lO8DR1NdXgQLXAl20tEL/6+tjcJPaunA1BDL1I/itXnGnnJxQVidD7Jh2OmAWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=b3ZI95dF; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4A12hq4jB2392059, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730429032; bh=45sj4NJAJZtRePSx0lOsNGqUtcFD/voHAcNitTeIQu8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=b3ZI95dFuIrpqYEjN/x5OHBgMVRaj0zBhxqT1URVLz8HR+R2TsFXQi6AJZRQFiHzY
	 mADdQKR00l5gIGm5tHdYFsocw9tX/p3lAnpWtBzhEDuMVidiWWepBB3cW+TSwi7NcA
	 Nb6gtrJ4fC9LVV5AonChqfg5y1MGkjoMOXtYhUqrRRpSAD8mOE/XVOzgdtxAnf1B0w
	 JLGUb0wLHZOA8K4CdZzFxuh9dtoYkMso1skMZ7NlF/9IX1gfZkXZyNwdMRRm2s8p8T
	 2n3uNOBvnoHhL1PIW2l46DEzKqHVTk7fM3QJevsH9NoIYGSnca24lU+MiSb0WDTKkY
	 BDmgz9Ck6gcSQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4A12hq4jB2392059
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Nov 2024 10:43:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 10:43:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Nov 2024 10:43:52 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 1 Nov 2024 10:43:52 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        "stas.yakovlev@gmail.com"
	<stas.yakovlev@gmail.com>
CC: "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: RE: [PATCH v2 -next] wifi: ipw2x00: fix bad alignments
Thread-Topic: [PATCH v2 -next] wifi: ipw2x00: fix bad alignments
Thread-Index: AQHbLATvfGcwlBRPY0u0jdLBJl/xr7KhtuAA
Date: Fri, 1 Nov 2024 02:43:52 +0000
Message-ID: <85f5348dd18949f5a4033dad982882ec@realtek.com>
References: <20241101022215.6667-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20241101022215.6667-1-jiapeng.chong@linux.alibaba.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wrote:
> This patch fixes incorrect code alignment.
>=20
> ./drivers/net/wireless/intel/ipw2x00/libipw_rx.c:871:2-3: code aligned wi=
th following code on line 882.
> ./drivers/net/wireless/intel/ipw2x00/libipw_rx.c:886:2-3: code aligned wi=
th following code on line 900.
>=20
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D11381
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
> Changes in v2:
>   -Replace the & in the if statement with &&.

I feel what Kalle meant is like this:

if (ether_addr_equal(hdr->addr3, ieee->bssid) &&
    (fc & (IEEE80211_FCTL_TODS + IEEE80211_FCTL_FROMDS)) =3D=3D 0)




