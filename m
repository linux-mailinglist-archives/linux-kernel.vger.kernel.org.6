Return-Path: <linux-kernel+bounces-512144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE2CA334BD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 02:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 085A2166B34
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 01:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A39B81AC8;
	Thu, 13 Feb 2025 01:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="Nu1khmJb"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16091A29A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 01:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739410396; cv=none; b=B0om/vr+Lb+Xr5RXryOdEc4I6kO+UcZuHno93Z1HhPiS8nMjFyBnxxBSBLei1TlxUt1ZFHJDmc9HMwyzDLOSHJvpl5LI/yCxRMpCPNelNpK5PZoG9Z7Xs7VTq5GgDVJCeisUn0aEAG9dlOEeY/5ebReYfCid6kP8DpevZvOdZFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739410396; c=relaxed/simple;
	bh=NvZbc79tmoA4Z330iQvo+kQeIxym98tc3NIyEQSAXsc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kc7LfzHY6bOQJE2fuh2Xs93zj2mi4K90hMC0fOhm3uPzDWd0d5ybZV7fWmfSHU+vqCen3jIJJy9xRZ0pkhE3o8nv5C6kPdGvvxiPMcA+os2A6pm9GBvtnpOwz0Iiu0QULCvbnQ3jNlLBx2la7YqK5S5yKJU2DZAIxL9/Ttq7eyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=Nu1khmJb; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1739410391;
	bh=NvZbc79tmoA4Z330iQvo+kQeIxym98tc3NIyEQSAXsc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Nu1khmJbE9/annnaiBiWNDxwALKhf+chDyLE2L/txj9RcneLWny8rnV26JqSLQbFS
	 ftvxesaDv1QdigXCCSrNiclaH9+lrslYM0ai0w1aiG3eMmycmdwewM/rWMSFKn1oKz
	 rhY4k3+5dviG41FAdzHKmrr0CbQ7ynvr0ZHdLyL5oBfUpT2AFBBl8iKJo2PR9vSlC6
	 7a4Ok2YE8bsm/VrdGiSLkIz7C4GZI0gLvkERhw1bTPkXdnWscEgqz2jopXZKIKvpZ+
	 tissJqvTeZ05i6tXwm8Ld8feWa6Cn0iWdS+pN+5tADuP0r/ic4/q5vlhv9FZ1bOMUw
	 EmUrGFMrJHRQQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ytd3q1P21z4wyh;
	Thu, 13 Feb 2025 12:33:11 +1100 (AEDT)
Message-ID: <7771db0e45a7152f42cbb45423ff9cca9a95dfd8.camel@ozlabs.org>
Subject: Re: [PATCH] MAINTAINERS: change maintainer for FSI
From: Jeremy Kerr <jk@ozlabs.org>
To: Eddie James <eajames@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, joel@jms.id.au, alistair@popple.id.au, 
	linux-fsi@lists.ozlabs.org
Date: Thu, 13 Feb 2025 09:33:10 +0800
In-Reply-To: <20250212170827.1477102-1-eajames@linux.ibm.com>
References: <20250212170827.1477102-1-eajames@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Eddie,

> Due to job transitions, both Joel and Jeremy can no longer maintain
> the FSI subsystem. I will take over.

Sounds good, thanks. Given Joel, Alistair and I no longer have hardware
access, would it make sense to remove the R: entries completely?

[I'm happy to do keep an eye on patches, but my usefulness would be
limited to cursory review]

Either way:

Acked-by: Jeremy Kerr <jk@ozlabs.org>

Cheers,


Jeremy


