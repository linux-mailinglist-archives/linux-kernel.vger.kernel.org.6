Return-Path: <linux-kernel+bounces-319842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1C39702F7
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 17:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 460391C218C7
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 15:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4B81B85DC;
	Sat,  7 Sep 2024 15:33:10 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD7C1607A4;
	Sat,  7 Sep 2024 15:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725723190; cv=none; b=Al4RcJYU6ssCgo+qKQmA+o7ickaYBcFBz9wOTKJFojHF8Y7nMJ634+qBR82iHWgEVi52DQI0XVJY3nDkQzb+eIynDlCvnRcwLkbD31iw1hpVrMZrwvdE2LKk6fo+QF4oQp4YYYpydQabZVuyRS+ZZKQe7gO5XLX5rGbYJ9F6I6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725723190; c=relaxed/simple;
	bh=5Grk9i+ayskQeimGL1KQs0rbB/eta7cII/ijyKCM1fA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ffQ2u5SCkih/j/kNhnzGsdGdpy1tJpa8C1NfP91uaOG1PBY5JhC21IfM0jQHfCAjisfdXoxNu/WF3UFPjGecruwN9U16MpG7eT2+VZzg+ShIMSajgD748JMVzL00vncuBb5ephHftVajanrngNa/+ES4WI72YXkd5ewImyXeRZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 1CAA4161749;
	Sat,  7 Sep 2024 15:33:06 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id C84CA2F;
	Sat,  7 Sep 2024 15:33:01 +0000 (UTC)
Message-ID: <d13c59eb55ad4822878eac47dd2ad339a95f5cb9.camel@perches.com>
Subject: Re: [PATCH 2/2] checkpatch: warn on known non-plural rust doc
 headers
From: Joe Perches <joe@perches.com>
To: Patrick Miller <paddymills@proton.me>
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, aliceryhl@google.com, 
	apw@canonical.com, benno.lossin@proton.me, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, dwaipayanray1@gmail.com, gary@garyguo.net, 
	linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, tmgross@umich.edu, wedsonaf@gmail.com
Date: Sat, 07 Sep 2024 08:33:00 -0700
In-Reply-To: <M4qWISlO9z_OnOQGC5Gqb0ROgBLsxM35tR9HU_DMJKExPFpJrEYTuBa2mO5YQqvQK4h65hZrNB165qJlOnexLXaDscRuZcmAkOC0AH4SO04=@proton.me>
References: <20240906180456.2302688-1-paddymills@proton.me>
	 <db693ef6c064fa42eda323f067d4270baf68b1f5.camel@perches.com>
	 <ct-Fmb-XUaJqIhpE1RlzXwIHxv2fWKgeiD4_j3xguKMCL4vwyYn8qzv_fKjulO9GmOW18h0jzPkiRgNfym5HyUhPVBAKHJnhAH5WhYAVKNg=@proton.me>
	 <M4qWISlO9z_OnOQGC5Gqb0ROgBLsxM35tR9HU_DMJKExPFpJrEYTuBa2mO5YQqvQK4h65hZrNB165qJlOnexLXaDscRuZcmAkOC0AH4SO04=@proton.me>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: C84CA2F
X-Rspamd-Server: rspamout01
X-Stat-Signature: ezwoojqkayc94o8h6ccag1jhhq4xggwa
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/Gr5L2r5k1cS4eHbqWttFDCQtwFLLuk1g=
X-HE-Tag: 1725723181-989439
X-HE-Meta: U2FsdGVkX1/ClEVVD2diQPqXXF39CldoVYAmD4008x9QIyw6pUp7yf62IKSICf9dUs6HG8ux6OZItW8i3ey8o8+LOQnDn1Q78B1CIRUby5W1PQmqUV1wlHQ2fQnGBjp50HCcofEhbVUuqjprNF2YGj2c6Sfs+G6MipYMfwdzKGYXsueJ0a7c2n/Jgn0Pw2HMBqWCoWXpHy2E2aLTszPHdxoSerDS+3fA85lEaKBPPzeyVMQXM1jGzFAPrIQlQ/dFHw4AtFXT2F2SdYn5d4aPed+vCHO424jUXE+V9ugzmX7HBFH3RM9nGHdyb8oyK5EC

On Sat, 2024-09-07 at 14:22 +0000, Patrick Miller wrote:
> > > > +# check that document section headers are plural in rust files
> > > > + if ($realfile =3D~ /\.rs$/
> > > > + && $rawline =3D~ /^\+\s*\/\/\/\s+#+\s+(Example|Invariant|Guarante=
e|Panic)\s*$/) {
> > > > + WARN( "RUST_DOC_HEADER",
> > > > + "Rust doc headers should be plural\n" . $herecurr );
[]
> > There is no autoformatter for checkpatch/perl/etc.
> Can you elaborate on what you mean by this? I'm not following.
> Is there documentation you can point me to that I need to review?
> >=20
>=20

[]
> > Will fix this. Is there a code style document for the perl scripts?

No.  It mostly follows the c style though.

