Return-Path: <linux-kernel+bounces-235124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB4B91D078
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 10:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E28D1F21561
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 08:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565BC42ABA;
	Sun, 30 Jun 2024 08:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="l/i2vC5J"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536393A268;
	Sun, 30 Jun 2024 08:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719734876; cv=none; b=bIBvTXGI+Jsh10GwPpY/FUa0uCVwu67XLnkvE3kPWIiD2SU6TDGwB9LBW8nPyas94fuNqhCLmakOTsfrYa66NQvDaCwyxCcJl4CPFASwrsFOUHCwKSSj+xPw0Ye/du2kDpIKfzpQXeouNjCl7695k12ma4iSikeXLNlmaV0RoZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719734876; c=relaxed/simple;
	bh=lNuSaJ11QtPi4mbe4FqYY/z0bjszGfu+9HvYgYhmTKA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=htHxDoZuls77Fyz8ej6TCz6dZ9uKGnNYmhkqTlqjJbA8GNE6oJDnv4IIaS3y5DdF2wDg7nadKA660HYbrTM1vGRl77uj6Q2OHTMnBQVh1ngkngliIwUOGdBr/6XUMERYSC/OgXe9JhZHKDBpIsOEkpsKEe5xwU36ngvXHZg5V/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=l/i2vC5J; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719734857; x=1720339657; i=markus.elfring@web.de;
	bh=lN5WQT/P42Agtm6YWk9SosCJtGnpAgOUpbIGynjUq88=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=l/i2vC5JDLAolxVTBtLSrqQPvGLYRc9QVqTBWYel4k8jFSR+cN2MFmoFjZn2xZEA
	 VmGw9mo3WExpwoYSeNfgRgOv7ja3e+CVuk4QCI07EVDrP1T7lxyo9nS8+Jc4fGH75
	 RfI6lf8KLCACvobaqiS9+5GVtJ0iRnXxxcezMVKd1g7jfTFo/p8UNY6We1xi0MM4y
	 /7NiMLV4sgUDxFXBqJq1psYVL5IcMeBK5WEdD073yZiGBVUHdrh2JXqV1BXwVhZtL
	 0Tg+l2sB8co6oPoS799zQs3DdnTgnVAAEvvbvGHFHpEDzw/L6oGz6bk71HaFfCCKF
	 mLDXTzlaqwKYMDyQpQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MuF8z-1s9Tfg1e0r-011PFz; Sun, 30
 Jun 2024 10:07:37 +0200
Message-ID: <005f0c44-25bf-4e50-a660-9a298a164129@web.de>
Date: Sun, 30 Jun 2024 10:07:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Keith Busch <kbusch@kernel.org>, kernel-janitors@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>
Cc: Keith Busch <kbusch@meta.com>, LKML <linux-kernel@vger.kernel.org>
References: <20240628193514.1680137-1-kbusch@meta.com>
Subject: Re: [PATCH] PCI: fix recusive device locking
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240628193514.1680137-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z7GOR5Oam3BF13l4JmM7FgI8WpNGmFdJPfOk/1a2ZRVEsPeyxzG
 it6SNDjrL6bIn4PlogTF8z3CrM8+N6gaMBrhC2MUm7a7Bv4GJ3jLoqrOlq9YiP9ao9fGNU1
 AK6RcSvXlUv8aLE/cNlL2gQj9Ly97yOMNAYKEfy38GJ2I7Lt7UJu3q71DhIdeRA/dwSGVNP
 KZu9BY7PeliRTBQWq/qag==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aoaQQgYZuWo=;wHqimmBKHoMU8h9+2o8BaCzkeag
 gTZsPwIQyygCJ747gHiq7sEN6+FNMnQj50ZkLt4odnw29qvuIlIb/eN3WjNgjrXUkZF7MX5gc
 zxjjr20+HG1YiA3YuJyhVpk1g18UsefKEInfhtY7CvsYQHqwIa98wugt6KZXvnf5QL8mU2XIs
 zht0Cx1zcNZo/fH/4Yf4WZ9IHuXbe/ErjUfJeLD39fkgksqKBjsS9ZNTpx+7lrWz9D+3bCU1R
 VTHB/gnGTdssCFlUeSPMxjxTvQLg/T9VeVMnnTYr14yXibHdzmrH3Xhb1hxOZiNlkIrqu/vY9
 +jBvc5RYSlCVDk6JRclwdDnUippTHD5gzVvl6aLdkbf50ejrYjKjyfybGP4cF4N7LAOdrKB1U
 0PVZBOemxDHp1byDsTPFQB1CW2GuU174W4EJrgNTCLXSCNx+VpKMtkg8xnZUqxTMoShrDpbtp
 xGlDoSmgqsd9tpA2H+au1kbbqLuqv8fBo0stQ/Sd7ZW94KmJczJX3o1UkeCCrOlB6zFMWBRG3
 7r6DC7/uRssEQwKXeyjI+Q+sUokqBJtJyFnP84fjSQxDUS4C/lcgqGMGkcOT8lXO9iK+T2s15
 n0jNjsPXSm2odfngrhXmzlXv/35OTu11DEbGsFi+1lMsOl8FSCDYFhl0k8p7okmm9rNopTF3v
 9yPTvtC1IP8JyAUQPWplwetIOyG1swj/4y/dFSLhSd0ncQRCoCT4Pb+dLjBUrapMGTFAlJzuZ
 j4BJVaWEvAwFXaTlJZSszRTr7VVTuCfiN5+JofzC250RwhS3NftbI5V5ZPyZbCAuGY/i1cHWQ
 WiYp5XgOjNcI7Op3OzDAEtYA5AbtBIHlkcxxufCreUhbA=

> If one of the bus' devices has subordinates, the recursive call locks
> itself, so no need to lock the device before the recusion or it will
=E2=80=A6

                                                   recursion?

Would you like to avoid another typo also in the summary phrase?

Regards,
Markus

