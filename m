Return-Path: <linux-kernel+bounces-242206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9F09284F7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B7DC1C22B2F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596931465BF;
	Fri,  5 Jul 2024 09:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="R7xEq5ze"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA633A8CB;
	Fri,  5 Jul 2024 09:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720171157; cv=none; b=jt1s6OFuanbUQDemJ6PQSWWHUJzIvaxxTk+hr+h8uywtl38c7az5dYZTCZa6xdUfWh+nGQ+57ec9jpungeA+MP0xshrycyTT7g7jvZ+XR6d2mh4X5Z3pfj726BqTWi2+Z/qlrQnxZ35dWdlzRBYiKT+gQwzlVXCLddIuTkcfZeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720171157; c=relaxed/simple;
	bh=h7tI3UX9MF6Z8Rfjd4kC9TY6gTQpLashC2p1HGV+8b4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=lDvQPq73RrxrY6P/jToLlJ7mHsCuwV6p9XfvcAeDligXtz40aNE0ciH3j5eJHTbR+mDaOAo6qPSLlshjXnECSQkl+GyCrfX2XEgXpxW+ozJSVRjKBO8K2J9jXttRyi5SdWnMtMq61DgB3vuCyNvwny8Brzm+ZgqfrREHvGFAGEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=R7xEq5ze reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=lfNkSWR+BPmvBsA3/0LjgsVzzxpvFDzXGDNdUl4T8cQ=; b=R
	7xEq5zeF8zahh3ljjQwi4Yqw1bsINRy/6D+hShk0ZpRrEjppyW68IVvAKuQ+rSzN
	tB6YkiXkdWLaFqMtRLNuD47d3gCv1+BGur3CrwDJfhCN+vvBoZyxxp8PbSR0hGwm
	hgcfNEZqODwgaH93W2iCzPAiZJ7EsjYdf2MSzbegrk=
Received: from vanillanwang$163.com ( [124.89.89.114] ) by
 ajax-webmail-wmsvr-40-137 (Coremail) ; Fri, 5 Jul 2024 17:18:52 +0800 (CST)
Date: Fri, 5 Jul 2024 17:18:52 +0800 (CST)
From: vanillanwang  <vanillanwang@163.com>
To: "Johan Hovold" <johan@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add Rolling RW350-GL variants
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <Zn0SY4nQzESrQ4xw@hovoldconsulting.com>
References: <20240531024012.29805-1-vanillanwang@163.com>
 <Zn0SY4nQzESrQ4xw@hovoldconsulting.com>
X-NTES-SC: AL_Qu2ZAv2cvkko5CibZukfm0YWgOk5Ucqzuf8k1YZTO598jBLo9j4Qe1xgLXT998KNJzmtlzu0WRx/58FkVoZ0b7ovXxPWZFjlzJtstf+vF+hJQA==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5273fe7a.9647.190823077a9.Coremail.vanillanwang@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3_7t9uodmlHEoAA--.7805W
X-CM-SenderInfo: pydqxz5odq4tlqj6il2tof0z/1tbiExETUmXAl9mMewADsc
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

PkNhbiB5b3UgYmUgbW9yZSBzcGVjaWZpYyBhYm91dCB0aGUgb3RoZXIgaW50ZXJmYWNlPwoKSGkg
Sm9oYW46Ck9uIHVzYm1vZGU9NjQsIHRoZSBwb3J0cyBhcmU6IAoKICBNQklNKE1JMCkrR05TUyhN
STIpK0FQIGxvZyhNSTMpICsgQVAgTUVUQShNSTQpICsgQURCKE1JNSkgKyBNRCBBVChNSTYpICsg
TUQgTUVUQShNSTcpICsgTlBUKE1JOCkgKyBEZWJ1ZyhNSTkpLgoKVGhhbmtz

