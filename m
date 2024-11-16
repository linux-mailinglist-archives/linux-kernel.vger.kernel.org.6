Return-Path: <linux-kernel+bounces-411669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F12D99CFD9A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 10:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 829BEB289A2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 09:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D79194A52;
	Sat, 16 Nov 2024 09:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="J2KXX/Su"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718A7191F7C
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 09:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731750134; cv=none; b=jes+BuRRteapwFVfN+9hwaDm8k2m7TZL/qjrayl864lC68RToAtZlvHFerutMQGiZbSdmpeRppYjelL0seZtugFVTj9gmMEhNYrNv9D8TuC94s8VbG/tvWKqUEUvLRrrNJN4aVt7AOu9tNIrydWHmPD54X68tcqFD2iyNcfq89E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731750134; c=relaxed/simple;
	bh=U9emRweIjDuCq5Hej5AucUk8uRA06S0B+7MpUGrg5qY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oYFMwQ29ipAeYp7d8zk6uXw0fYNfuDpTv0tRYZfzOGLFY8d0b7pn0IdLc0njHbto1uPON5tKrDImD7ppLgXqDUwY9knFUwmIuV9/l3lWADiXRPDLJ8hixVs7H9Z7APWs3uE6xGrxe1lYntm+oU1b9npIeMLTWxVtDZ8TEhZt0jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=J2KXX/Su; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1731750127;
	bh=6Yr3v8h2TldfiCcRyReOQGJPZNnddjXSKjFgGcIyKP8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=J2KXX/SuxtCkozOltk8pyFMZIPW8v6gjTXxskXui5BZL4pooA3xpBeg2DRtSe4Eji
	 4bVTdh6R+RO+fB01qsqbd5WIJqB4Scw7nND4rkZ9ZF5DeLcvkJvcXv833vANEYsmN1
	 sl2ICJ3VxsWrfSD7SeBppusvX1XaSNUBWia40JVc=
Received: from [192.168.124.9] (unknown [113.200.174.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id CA72D1A3F68;
	Sat, 16 Nov 2024 04:42:05 -0500 (EST)
Message-ID: <0509da76bd3be0d4c7ff433da854ae74cd367d5b.camel@xry111.site>
Subject: Re: [PATCH] soc: loongson: add Loongson Security Module driver
From: Xi Ruoyao <xry111@xry111.site>
To: Qunqin Zhao <zhaoqunqin@loongson.cn>, arnd@arndb.de, olof@lixom.net
Cc: soc@lists.linux.dev, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev
Date: Sat, 16 Nov 2024 17:42:02 +0800
In-Reply-To: <20241116085729.12651-1-zhaoqunqin@loongson.cn>
References: <20241116085729.12651-1-zhaoqunqin@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-11-16 at 16:57 +0800, Qunqin Zhao wrote:
> +config LOONGSON_SE
> +	tristate "LOONGSON SECURITY MODULE Interface"

"Loongson Security Module" as there's no reason to use all upper-case
form here.

> +	depends on LOONGARCH && ACPI
> +	help
> +	=C2=A0 The Loongson security module provides the control for
> hardware
> +	=C2=A0 encryption acceleration devices. Each device uses at least
> one
> +	=C2=A0 channel to interacts with security module, and each channel
> may
> +	=C2=A0 has its own buffer provided by security module.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

