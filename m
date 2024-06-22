Return-Path: <linux-kernel+bounces-225741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA3B9134AF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 17:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FB3FB21E1A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 15:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6DC16F0D0;
	Sat, 22 Jun 2024 15:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="nMd4E4gZ"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96871E4A2
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 15:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719068957; cv=none; b=W8XEcPooG8ZaW0eH2/UGNYLX6SCXSYYxBSTS/pnAdfMzpP9YcG5+6mPPJKVQc1bM+ycq6kIbojW5O8MkWvney/BqUJC7zQH5M/3Xrj0GdKoqnIDGyT/gLl8c2oblPrP6aGIYHvUaUA0OUItyasHFcdSxrSCzYOItUlfwq7ENOzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719068957; c=relaxed/simple;
	bh=iy38LNt4aOhw4Dg48ya+l+99DAEUIoa0MD7Hu6B44P4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=jhXqTtYYHbkslJMtyu+Z2wj5oYPE8nuaaCjzMloywiyVjE7DRzuKn08kSSHw3DeWrKLjDLaLmDWVouT0ISFeXHqzY8kLFxDOO7bhe2NsiygmtDjA+yYzLYKQ6urDL4uO7N5SipMXtiZr73r58D6FWmQ0XQbfNOOU1XcZSDUn36U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=nMd4E4gZ; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719068920; x=1719673720; i=markus.elfring@web.de;
	bh=NFuZ6M2STN20QrhZvyeG736clc+fBOFNekM/fFkH9Vc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nMd4E4gZwwFFno24Ni5ZQVe67BTK3FOhC+Sjcglh8OoJ16pD+j/fiY46GObKlfzR
	 WatA2CR3VgLc5HKX4x+wLXaWNYNjoNFKFQehaJkdmKEtUBxvh4Er6h26DI7CU1Q57
	 P2Zk+BDUwFL4Fl7tEAKaUh4IafIgd7azz7vwgwz1KSQjKACj2JX+FbrwJEyrhWyNm
	 hIfFXJ934kiEP1CQ2vzDsQsOja3v2xJwW/7fNPZcTZ781dsWKBGVsA6Gv5+sAavTV
	 F8KCME25R/6WXWRxlVtwuFCaXejZ63AqgFrimUE45w/OgsqiVW6ZziVaJbAAfZW/S
	 CjLVoNFvAl81jiezFA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MPrPT-1ryiNP32Yd-00X1nu; Sat, 22
 Jun 2024 17:08:40 +0200
Message-ID: <22810fcc-4de8-4f2e-886a-6af83195028c@web.de>
Date: Sat, 22 Jun 2024 17:08:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ma Ke <make24@iscas.ac.cn>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240622072514.1867582-1-make24@iscas.ac.cn>
Subject: Re: [PATCH] drm/gma500: fix a possible null pointer dereference
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240622072514.1867582-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uKlUyj3Lobz03Dm+uCTyo7AVFryCJFA1isK7uPlHq3jgrmTjUSG
 EkgC84iTkkbyLp4QzGCzgr5aZYxvU5OODpWu7mlpwofCyDwGXEZ90UG2T9jJU3kOd3yKn5b
 iPDaZOsyMRdAoryOHvttOchWqOGkKaphMbV4qym+LnqcE5Aln2p2fcnZNR+ULfxKR0TZvO3
 MfhychZs2PSGoJGkBwysg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:J7ICRNDoOl4=;qeMy2KtaPZ0r60MYq0eOTO/JqOt
 NBB5ASspRnUZ+KARRQUoPV58jJFYsngKokwrfoXxQ4K+BMwydVj2nScYNyLBOzsOCRtwCoKr2
 UdqDPAOAHCMvE/wa/hwrFBRCTNPoEOsQ4Tc2fEOP+KSVgSGQookBRL3khNZW3csZGohHD75Q4
 2nGvaeXVKqWRVMC9s7dOd8iClbtF1dSeQ547ZjVREEyIC3sXq61yV9Y/oG6aiEhuVvbZUzYHZ
 eIxD+yj+koeti56zGfZzUuSROhNB8h5wkX/q8eFkEtibBfYf/4LQKFsD9QTiGbcNAEqTilp5E
 jFLc8iCCyYByMwmoALPkh4fJ5OEqrJ0xe2zu05i73kmu7eWVLYV1ruJVyZV9IOZVKwxhIZspV
 cyWVQvDPt8jqVZYJ4rm1HRyTrrRLP3E7qin6rw/Vbe8zSX5m9QPzf0MzIhfhjd+hQEKC9vfKw
 YJ96lOW2xf0er2NA4UI5G/XFmQgnyb6k7vaunFGyAREdTDfW5d7OuIS9UIkVDHW7nBvYsfMov
 3N3fZTyxgN7UDEHpCjHqv5cR1HZ5hg/2EPvwIf+ARf+glaj5AN2W2W5326UyOVTnNjFwk2x4d
 cY60/9IfQg5YGgk4ouu9HEvtqEtgcP3DR4gcRJ+7PUjzJaQstyEot3zdmPeGYDU5S9bvSgCqN
 1crk0zcJ4bqnLTVvNtv4Fn71XNIuZ044LZl3tRWaU20F4aCTRzTLdqEm4vhCOGSh0ugorNYbg
 Q3JoVyAxBHgPaJVhdrTHkU3auQCqoVrF7SNLUiQHPygTILeXRHs9fxbHyXSqB8ag0pP73Ls8e
 0ivsZQw087a7ye95sOWsXci9MSuPmMuJ1wsLY55fmMdng=

> In cdv_intel_lvds_get_modes(), the return value of drm_mode_duplicate()
> is assigned to mode, which will lead to a NULL pointer dereference on
> failure of drm_mode_duplicate(). Add a check to avoid npd.

1. Can a wording approach (like the following) be a better change descript=
ion?

   A null pointer is stored in the local variable =E2=80=9Cmode=E2=80=9D a=
fter a call
   of the function =E2=80=9Cdrm_mode_duplicate=E2=80=9D failed. This point=
er was passed to
   a subsequent call of the function =E2=80=9Cdrm_mode_probed_add=E2=80=9D=
 where an undesirable
   dereference will be performed then.
   Thus add a corresponding return value check.


2. Would you like to add any tags (like =E2=80=9CFixes=E2=80=9D) according=
ly?


3. How do you think about to use a summary phrase like =E2=80=9CAvoid null=
 pointer dereference
   in cdv_intel_lvds_get_modes()=E2=80=9D?

Regards,
Markus

