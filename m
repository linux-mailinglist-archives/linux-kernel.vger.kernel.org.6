Return-Path: <linux-kernel+bounces-422965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 315DF9DA08D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 03:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCCAE28386F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 02:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E551CABF;
	Wed, 27 Nov 2024 02:10:28 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3395D2FB
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 02:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732673428; cv=none; b=IDnAcYw/xfNzaik/TthiXQOsG6oQd4JlGI1HQPnr6L9xJ6X5lMsKw8Zx6tDkUpY2i2yavGiVKs2RUBqy77Zi/xWkMP+uCtfX2iQCVOCXjIQX8yLlr8yv7xEZ7NbMqc1zlDnHvYCwVyguki2Fxu9k8RliUeR2jApPEa3XUgZnwgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732673428; c=relaxed/simple;
	bh=YUtkNfhQq2R3Ll3cfb/vT81i7hoJpn+jCi3CzCHE3lI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NKqlMopBYAAOqs+yKuFvvMHNrUaJAvK7+kHeFrWbcdm+zPx3T6zi+OYgik9NTNrh8nUG2IFDfOdbakAamsMsDxqEAxqw5gXBAoqh5nVwctMRhp33OUySCXaat+DgDLl99+W1mIOyuUBMbeibLwO2WsXr3nSVB8fAbQO4MKcugmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee767467f8603e-8b05b;
	Wed, 27 Nov 2024 10:10:14 +0800 (CST)
X-RM-TRANSID:2ee767467f8603e-8b05b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.96])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee867467f85bf3-4e727;
	Wed, 27 Nov 2024 10:10:14 +0800 (CST)
X-RM-TRANSID:2ee867467f85bf3-4e727
From: Luo Yifan <luoyifan@cmss.chinamobile.com>
To: linus.walleij@linaro.org
Cc: ardb@kernel.org,
	arnd@arndb.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux@armlinux.org.uk,
	luoyifan@cmss.chinamobile.com
Subject: Re: [PATCH v2] ARM: vfp: Fix typographical errors in vfpmodule.c
Date: Wed, 27 Nov 2024 10:10:13 +0800
Message-Id: <20241127021013.4953-1-luoyifan@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <CACRpkdauGxfiobFHRJfkRYASZ3GhosTuKNPjQc5sFMhWDCR8jA@mail.gmail.com>
References: <CACRpkdauGxfiobFHRJfkRYASZ3GhosTuKNPjQc5sFMhWDCR8jA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I have submitted the patch to Russell's patch tracker, and it is now listed under 'incoming'.

Thank you.




