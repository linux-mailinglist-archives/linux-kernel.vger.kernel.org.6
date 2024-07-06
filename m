Return-Path: <linux-kernel+bounces-243401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B10F99295CD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 01:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 679BF1F21968
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 23:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C509D13C801;
	Sat,  6 Jul 2024 23:13:09 +0000 (UTC)
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A544E1A2
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 23:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720307589; cv=none; b=fVn7Gx5r/ENrl6gqvibBjU5U3Ry1bcvdMP6wAv0qffycRx7sa++ntRa8s3m6zApcXKT4HYifKImL6MIJfQIpiDizbiv7ct/FX8/jLLWCHmE1GPuKLYQbuURRkTVFAHd5EzxSnwZT/bO29U6631BI7Ckk1O8zu3Ts6B3oNI/SV6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720307589; c=relaxed/simple;
	bh=uvw7kayH72MKWUgP6tooALqZ+prlnp+fvkEIGqh0Liw=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MEC3hkQZHqTM0fDQ8lz39+M3L9+9vXXkzccQZYKRPnmx+bIUI+MzLvoE/FGtjw1Dtwyk6VBFbNGKUzjRR4WfZjg24Is1VAABUkN1qJT3cR1XKY6cw18cl3Y2PFYoqjc+5ko9eEMs4Kvy4/EyUzZzzGG2uLsd/AGj3TDt00Tjpl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WGmQ3421Jz4xPd;
	Sun,  7 Jul 2024 09:12:59 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240509-mac_hid-md-v1-1-4091f1e4e4e0@quicinc.com>
References: <20240509-mac_hid-md-v1-1-4091f1e4e4e0@quicinc.com>
Subject: Re: [PATCH] macintosh/mac_hid: add MODULE_DESCRIPTION()
Message-Id: <172030740423.964765.11410477570460429115.b4-ty@ellerman.id.au>
Date: Sun, 07 Jul 2024 09:10:04 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thu, 09 May 2024 18:23:37 -0700, Jeff Johnson wrote:
> Fix the make W=1 warning:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/macintosh/mac_hid.o
> 
> 

Applied to powerpc/next.

[1/1] macintosh/mac_hid: add MODULE_DESCRIPTION()
      https://git.kernel.org/powerpc/c/50b5fed94e21c0992c79fafdd041c9863c1fd2d2

cheers

