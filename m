Return-Path: <linux-kernel+bounces-418098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8439D5D2E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 11:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 569EA1F234C8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2762D1DDA34;
	Fri, 22 Nov 2024 10:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=skogtun.org header.i=@skogtun.org header.b="PtOfpKoO"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755B7171088
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 10:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732270929; cv=none; b=dAbg7QAo2dNU4G0YkgYZhWbFG/0cDCIzhiYptyqO0L1WwPHhndV3Bj4ZLOQhB19GgN0UGws7JGweIVFYwi4nKcJUNdOMPZzCqrd4hdakt/tgqjJOfVrRGvPaCI/IpBbGlxDFgzrRM85cTZECVYC2exvUnA1LoG1xpylbsXGf1UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732270929; c=relaxed/simple;
	bh=MG985j4h4TEB6vNdUcMB+J3tnWRBV2SkyDurD5EmC/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k0k/inD1mG4ohuyC59TswCQ1+IhGnlsVy9LUmkosrwQItNAMh+1FdIMDb+v2Z3RUn2n0IB1LDgqYxiQOb0NqPCtiNLpTfiKsPURz5Q+wTUncJojWsADtzAGa2PG+MGrkM8vVIgCqnZgIz5gF+Ch+UgZYeSZ8TgwYQ2j1seBl8O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=skogtun.org; spf=pass smtp.mailfrom=skogtun.org; dkim=pass (2048-bit key) header.d=skogtun.org header.i=@skogtun.org header.b=PtOfpKoO; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=skogtun.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skogtun.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=skogtun.org
	; s=ds202312; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:Reply-To:
	Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=DEUzKWA6bADg0shRJcmS98hGe9HXD+YooKoL3Sweb+g=; b=P
	tOfpKoOpK8UdKCWyZMjhBKw8kBRL61Hex82xixPPpyn/fKSHmRqZ7w0sLXoxkn2TAwWwVsehTTquP
	uBtj2Mqktug2xHM5dFPkWl6XuT2b09W+VECjoiR6XwJx2GcUurQgAS2IrcdUuRg7VVI5sJeYd98kp
	2jG28uAfvof0pszkgVtpK3Sb09rxfQ04V5F/doIRO0+sYhR+QLHKhTs/N0fyxuTzycaKTVxYxdLYT
	HGFiaQcuHcpeXN5fk+6eRwQwQ0SrWi0NR6fmgELDzhqg51wARiTJC/vDs3RXJT+9kcusO8DhHMyh4
	y+pKnNYOXasyN+HhrAMmX2Nqg74ZQBpFQ==;
Received: from smtp
	by smtp.domeneshop.no with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	id 1tEQnY-00ACLt-AE;
	Fri, 22 Nov 2024 11:22:00 +0100
Message-ID: <b439fc9a-e0e7-4643-88be-6ffb85fc0136@skogtun.org>
Date: Fri, 22 Nov 2024 11:21:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] execve updates for v6.13-rc1
To: =?UTF-8?Q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
 "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
References: <202411190900.FE40FA5@keescook>
 <CAHk-=wgB1L75+C89AU62n4jBEiwKs=e4dvBDOoLQ13rUwJLFXQ@mail.gmail.com>
 <87jzcxv227.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wifNC+AAGVDN-B1gGNhKGqhnkoqWKCknAo6107oD0zGWA@mail.gmail.com>
 <Zz9sTFBQQSe1P8AI@kawka3.in.waw.pl>
 <87zflrsw1c.fsf@email.froward.int.ebiederm.org>
 <Z0A3EkxZZg19Dp9Q@kawka3.in.waw.pl>
Content-Language: en-US
From: Harald Arnesen <linux@skogtun.org>
In-Reply-To: <Z0A3EkxZZg19Dp9Q@kawka3.in.waw.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Zbigniew Jędrzejewski-Szmek [2024-11-22 08:47:30]:

>> I do not see any evidence that there are daemons started by systemd
>> where systemd follows the name in /etc/alternatives on debian, or winds
>> up following a symlink on a multicall binary.  The way I understand
>> /etc/alternatives I don't think you would ever want to use it for the
>> name of a daemon that is put in a unit file.

> systemd-udevd is one example that ~everybody has installed.
> (Though it doesn't use comm, it uses argv[0] to decide behaviour.)

There are quite a few of us who do NOT have systemd-udevd (or anything 
systemd) installed.
-- 
Hilsen Harald

