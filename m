Return-Path: <linux-kernel+bounces-539970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7F7A4AB6E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 14:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 918251897DEB
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 13:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434A01E522;
	Sat,  1 Mar 2025 13:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b="BEW/bnui"
Received: from mailrelay.tugraz.at (mailrelay.tugraz.at [129.27.2.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5971DED51;
	Sat,  1 Mar 2025 13:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.27.2.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740837346; cv=none; b=n5OdOoLo0uGcGtPToCcar/Mz4af7qx/UENE9kSIEwaipbA7Mz5+SU7/hSbtXYucF20mQw8bRaIVHnYSr9dYtcPgwM4SKPWey23w2aZR4Yt7uZSpkjBbHe4f57Juq60l5LZfgk8vYxU7sOz4FhiIVKMWafNc+WmaPlTUgunxczWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740837346; c=relaxed/simple;
	bh=57gmoHzKyTCBUERGazEXy7Bv1xyBc1syqfKuwhNym28=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n6wix7Gm4CJjqlD4o+wGQQkAF3ydqd5HRmFaXAU8oZRoyk+E56G9HN/t+S3uFb8fngCG5G/z7/NhoEPPSjv7ZMlnv6PacDlTWtWjRjmBmokpp/w73cUJ44Y6zj13lCF+hCZljKU8QYDy/absblEgSxCF6/SA7rVXYdHF/FLZ2NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at; spf=pass smtp.mailfrom=tugraz.at; dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b=BEW/bnui; arc=none smtp.client-ip=129.27.2.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tugraz.at
Received: from vra-172-162.tugraz.at (vra-172-162.tugraz.at [129.27.172.162])
	by mailrelay.tugraz.at (Postfix) with ESMTPSA id 4Z4mmk5Xw8z3wN4;
	Sat,  1 Mar 2025 14:55:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tugraz.at;
	s=mailrelay; t=1740837320;
	bh=vnR2UEaXdNo+YU9oMSVTVtceAtP9umT32kThn9x3Ib8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BEW/bnuif+W1TwRnOhs5KRi6YUJYW0I2uo8RC1jkYKdBuDw/SVb9o59162tpA2mrK
	 V+vrEf0V4IRn6OoX3YXyRnrkLYHqT4tIQhTD5QleRZYKGOWGJBEFQCy5OPAI3sEsAm
	 iG1shSHQIhSqacP6/vXIUiiRqqHyMIKWZt9VauB0=
Message-ID: <9ebf721647624d2474818384355ad1e6e2567426.camel@tugraz.at>
Subject: Re: Rust kernel policy
From: Martin Uecker <uecker@tugraz.at>
To: Askar Safin <safinaskar@zohomail.com>, dan.carpenter@linaro.org
Cc: airlied@gmail.com, boqun.feng@gmail.com, gregkh@linuxfoundation.org, 
	hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com, 
	rust-for-linux@vger.kernel.org, torvalds@linux-foundation.org
Date: Sat, 01 Mar 2025 14:55:13 +0100
In-Reply-To: <20250301132229.3115698-1-safinaskar@zohomail.com>
References: <61a7e7db786d9549cbe201b153647689cbe12d75.camel@tugraz.at>
	 <20250301132229.3115698-1-safinaskar@zohomail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TUG-Backscatter-control: G/VXY7/6zeyuAY/PU2/0qw
X-Spam-Scanner: SpamAssassin 3.003001 
X-Spam-Score-relay: 0.0
X-Scanned-By: MIMEDefang 2.74 on 129.27.10.117

Am Samstag, dem 01.03.2025 um 16:22 +0300 schrieb Askar Safin:
> Hi, Martin Uecker and Dan Carpenter.
>=20
> > No, this absolutely is useful.  This is what UBSan does now
>=20
> > BTW: Another option I am investigating it to have UBsan insert traps
> > into the code and then have the compiler emit a warning only when
>=20
> Clang sanitizers should not be enabled in production.
> See https://www.openwall.com/lists/oss-security/2016/02/17/9 for details

"There is a minimal UBSan runtime available suitable for use in production
environments."

https://clang.llvm.org/docs/UndefinedBehaviorSanitizer.html


But I recommend to also read the rest of my email above,=C2=A0
because this is not relevant to what I wrote.

Martin




