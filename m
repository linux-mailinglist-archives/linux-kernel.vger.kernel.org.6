Return-Path: <linux-kernel+bounces-519870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F34A3A2F3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABEE71651D4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72F71B6D18;
	Tue, 18 Feb 2025 16:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RibUiXdZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A1226B0AF;
	Tue, 18 Feb 2025 16:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739896547; cv=none; b=l2ksCnQBVy+kzcONOKbKqPMLoM81c+sDeEqFPVrzQ95m84MrmPby/Z2KM3+mbhMx02NppIxIRshss7RT9bPnAqtMxoDBnz+x8i6sbR+QLgV/F+X1pt8uUQ3TihSCqW4tqvqOzWxT+jC+ER3SMkaFX0dFkLkWoOJl+Mb01AUCPQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739896547; c=relaxed/simple;
	bh=w7JBv0Itab43P9O0fBMbKgbOx837okF7MY9ILu9zSVo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=utmw0IBVDNZtzAhdnUWN8odvvTvsY1QKPWJcsHdD7J/gCoOC28IzJJ6IYlI6XDMD5wZceqtQ3IPk/ED79HN5T59QBFok47063DEYughPX0zd0yknT12aJQn/G1Qn+P6ELtANfFlJa6+ZE3OVuXJxHktyBWqpSUeAp1zwR9wPKT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RibUiXdZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5EF9C4CEE2;
	Tue, 18 Feb 2025 16:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739896545;
	bh=w7JBv0Itab43P9O0fBMbKgbOx837okF7MY9ILu9zSVo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=RibUiXdZ8SKRertBNYUYpQRKLnYvoqzvD6sYy7pHiKkdcT8Ow2URjR7ZR+n7kvl8w
	 SQgzCRrjBp9HZqldX3MxJEG3TG/58+l/EG+fdoaupfXvc2ZZEAxfhAbftqld/i6KIa
	 yTAXCwiHbt03f2/2xR6XD3EXLk03dt4fsTPup+sOfEi4cpurxqYoOesJEr9Gv3DU2h
	 28kk2CycEUwimX78tmIN6PGv/WoRLMcBfHw5fI32tI8Tc9GFa14oTEv9NBxvUhkKen
	 AZXRFSHuUZMoaBPKQDiStH0mzr2OvZ39/zpQhlwzT4HlEvzQe/UXOFxXHRlE15MtqA
	 0eAjFF1qJS+Rg==
Message-ID: <36783d51be7576fcdbf8facc3c94193d78240816.camel@kernel.org>
Subject: Re: Rust kernel policy
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Christoph Hellwig <hch@infradead.org>, Miguel Ojeda
	 <miguel.ojeda.sandonis@gmail.com>
Cc: rust-for-linux <rust-for-linux@vger.kernel.org>, Linus Torvalds	
 <torvalds@linux-foundation.org>, Greg KH <gregkh@linuxfoundation.org>,
 David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
 ksummit@lists.linux.dev
Date: Tue, 18 Feb 2025 18:35:40 +0200
In-Reply-To: <Z7SwcnUzjZYfuJ4-@infradead.org>
References: <Z7SwcnUzjZYfuJ4-@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-02-18 at 08:08 -0800, Christoph Hellwig wrote:
> On Sun, Feb 09, 2025 at 09:56:35PM +0100, Miguel Ojeda wrote:
> > Hi all,
> >=20
> > Given the discussions in the last days, I decided to publish this
> > page
> > with what our understanding is:
> >=20
> > =C2=A0=C2=A0=C2=A0 https://rust-for-linux.com/rust-kernel-policy
> >=20
> > I hope it helps to clarify things. I intend to keep it updated as
> > needed.
>=20
> I don't think having a web page in any form is useful.=C2=A0 If you want
> it
> to be valid it has to be in the kernel tree and widely agreed on.

I'd emphasize here that MUST be in the kernel tree. Otherwise, it by the
process can be safely ignored without a second thought.

Doing random pointless annoucements is LF thing, not korg thing ;-)

BR, Jarkko

