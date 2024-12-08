Return-Path: <linux-kernel+bounces-436344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FE29E84AC
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 12:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 736002817D0
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 11:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE161140E2E;
	Sun,  8 Dec 2024 11:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bit-philosophy.net header.i=@bit-philosophy.net header.b="YewN9RQC"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E399D130499
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 11:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733657699; cv=none; b=p9WNglKSBH2FGVuiIzf3sl7MXVo/yctzqWnQ7iAnCkbWrRgLlyZU+/vJ6uNL/XTnfMau50MXrFuY2Fk1ti/bttzdHzmtAM5KVUEorcmVDkwcmAEgyX9NKuh/d8ODVXrTfw1Jf8tdm0MrHSYC/y1bfa7If2N5uN2eklQVBVwG/rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733657699; c=relaxed/simple;
	bh=bai2wTNXJtfYp7npZy7yStQiVZ989O0Yaj4OCLZz3Xw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=eClQMGoapk+vmBE2l/3jBho3gMQ2xCMh7C8ME8t/EmxW3tof9MgTJTDT0KqxLX/uqUvYyfuAbGezp4Mza4nzIKpF66EhRanEohrtB7ix3D7JK1dM0PUd6KYo9YR6DUL+hV6xe19e6wTs9EpI44m6upKf4NlFdnUfxibRZeJofrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-philosophy.net; spf=pass smtp.mailfrom=bit-philosophy.net; dkim=pass (2048-bit key) header.d=bit-philosophy.net header.i=@bit-philosophy.net header.b=YewN9RQC; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-philosophy.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bit-philosophy.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=bit-philosophy.net; s=ds202411; h=Content-Transfer-Encoding:Content-Type:
	Subject:From:To:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DDzeboG9MTTHaVhxH8FH/iawrC6ngXadP5cZMsjd7zU=; b=YewN9RQCjj1FDWlrFBvN+NFZqp
	1Xh7I0pqgMg5kn9rQkkwXYHebSrEi1Ev4xx4kY6JPWzk8GdkibeoyE1eqVB+FjTh0MeOo/1iT5sR/
	qSa4yM2NK5kfve3XoC/FefaItsiIc9Wm+EN2pKpphyqBnDJkJiQY8vDJf+Qx6gmA4CFWt94FADzEo
	M97ji4eTB8jfdP9DcOkljHew21AbE7gD4afORL68rGhAq0QuMpLAk36pNh9J+7C7Bs+4UKInMvI/Z
	9Y30xCrShyaCTcLJflq+RhVRAJmruJqodwvFkXdDU/jPqZYgFX9KmxKA7Segk1w8KJs5ejouSr9z1
	Nj/2gahA==;
Received: from smtp
	by smtp.domeneshop.no with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	id 1tKFYm-000OqZ-Hq
	for linux-kernel@vger.kernel.org;
	Sun, 08 Dec 2024 12:34:48 +0100
Message-ID: <9c8e7d6b-fd0d-48e8-9a72-f6e878d4c9e5@bit-philosophy.net>
Date: Sun, 8 Dec 2024 12:34:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <abbed@bit-philosophy.net>
Subject: Bit X (was Mandrake, Mandriva) Fair Pay Philosophy, Low-Jitter Config
 OS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hackers and Witches.

Today I have perfected translation of The arabic cORAN, that is the 
neccesary coherent element of philosophical basis for Bit X, a Fair Pay 
Philosophy, Low-Jitter Config OS.

It actually was realized as Mandrake and was popular at the end of the 
90s. Mandrake simply is Bit rewritten. And later was called Mandriva.

There seems to be some disagreements on the name. I suggest simply Bit 
X, as it was the basis of these namings, and it has no such problems. 
And goes along with the developments of Bitstream and Bitcoin.

Unix Version 3, was also designed according to Bit.

I do believe Bit is optimal for inner loop, and Yesu for userspace/GUI, 
symbolized by an @. That also tangents Debian.

I was going to work out the philosophy back then, and Gentoo's name also 
reflects this.

This is now done, it is like a mode change for reading the arabic cORAN 
in semicursive, with L'.

Hail L', Are of All, The Real, The Right.

Light,
Ywe Cærlyn,
Abbed.
https://bit-philosophy.net/

