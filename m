Return-Path: <linux-kernel+bounces-209980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F16F5903DA9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EECD51C23583
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CBB17D88F;
	Tue, 11 Jun 2024 13:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fDM5ZIK1"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DD017D88E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 13:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718113167; cv=none; b=WGO4nSQjx4/4U4JBZ55wNgwESAekbTLDY8lzwk7jMmwsywBAwPtoPQkY02UisAatvq22gv9+VyOyJH/C7aWwGaJsTy6RtopMX/q+3GNK9djLamLdpJ0qLobV89s/KgrAM+GTmJ/t9LpHKS0+6/W3DUtTP2I35IeZibNmFN40mk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718113167; c=relaxed/simple;
	bh=Oxe7PJjgp7An0AFVi5O4Owg2GH2Uw/6+OtjVK2JHGMI=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=dE0LN1GFkBejIhYUDE68e2JiBe4OxGYlPvA8W6eSKU4UgFp6vcjmxhR0Vs1rYccfYX5rPwgd1E5s1Wvq6GbSUoNRhclOUXfzkZfsobuxFogsEoWKTCPVSoAHBScy7EoNYjTPySx2zVRUNSEX6Av6KdPe5n2051uCPe8m5ZuIC50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fDM5ZIK1; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: dzm91@hust.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718113161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oxe7PJjgp7An0AFVi5O4Owg2GH2Uw/6+OtjVK2JHGMI=;
	b=fDM5ZIK1eSuXv0KAdEaRTW498x+rXXy3uG8P0EnDPBZb2uhTE9WBMScpMoNmndIK5ceR+9
	3lcIuL0vrNA2dWW6gqyYKNQkXNR4V5mTUgbqspDswoFIrN7a3s0gZgdoi9T5vllT+fg8yv
	WXeeGHu2OGABUFNvsSXKa4bfbvlO/PU=
X-Envelope-To: alexs@kernel.org
X-Envelope-To: siyanteng@loongson.cn
X-Envelope-To: corbet@lwn.net
X-Envelope-To: hust-os-kernel-patches@googlegroups.com
X-Envelope-To: linux-doc@vger.kernel.org
X-Envelope-To: chengziqiu@hust.edu.cn
X-Envelope-To: linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 11 Jun 2024 13:39:17 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: si.yanteng@linux.dev
Message-ID: <2e4f9b46821d4f40eadca253496816060c862156@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v2] scripts: add scripts/checktransupdate.py
To: "Dongliang Mu" <dzm91@hust.edu.cn>, "Alex Shi" <alexs@kernel.org>,
 "Yanteng Si" <siyanteng@loongson.cn>, "Jonathan Corbet" <corbet@lwn.net>
Cc: hust-os-kernel-patches@googlegroups.com, linux-doc@vger.kernel.org,
 "Dongliang Mu" <dzm91@hust.edu.cn>, "Cheng Ziqiu"
 <chengziqiu@hust.edu.cn>, linux-kernel@vger.kernel.org
In-Reply-To: <20240611131723.53515-1-dzm91@hust.edu.cn>
References: <20240611131723.53515-1-dzm91@hust.edu.cn>
X-Migadu-Flow: FLOW_OUT

2024=E5=B9=B46=E6=9C=8811=E6=97=A5 21:17, "Dongliang Mu" <dzm91@hust.edu.=
cn> =E5=86=99=E5=88=B0:



>=20
>=20The checktransupdate.py script helps track the translation status of
>=20
>=20the documentation in different locales, e.g., zh_CN and verify if
>=20
>=20these documenation is up-to-date. More specially, it uses `git log`
>=20
>=20commit to find the latest english commit from the translation commit
>=20
>=20(order by author date) and the latest english commits from HEAD. If
>=20
>=20differences occur, report the file and commits that need to be update=
d.
>=20
>=20Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
>=20
>=20Signed-off-by: Cheng Ziqiu <chengziqiu@hust.edu.cn>
>=20
>=20---
>=20
>=20v1->v2: revise the output format of git commits
>=20
>=20 add some description and usage of this script
>=20
>=20 scripts/checktransupdate.py | 203 ++++++++++++++++++++++++++++++++++=
++
>=20
>=20 1 file changed, 203 insertions(+)
>=20
>=20 create mode 100755 scripts/checktransupdate.py
>=20


Reviewed-by:=20Yanteng Si <siyanteng@loongson.cn>


Thanks,
Yanteng

