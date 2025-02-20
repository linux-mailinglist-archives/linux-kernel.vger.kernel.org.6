Return-Path: <linux-kernel+bounces-523160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C92EA3D2EB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DC823B3F46
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D2C1EB1A7;
	Thu, 20 Feb 2025 08:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UiyLPBMK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B54A1E9B2F;
	Thu, 20 Feb 2025 08:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740039246; cv=none; b=B7lFfQRX9eFOSFokDlkmXf/+RT1ZJVI7OT6CMh3/9pmmx26hh8xX2rPRkBjqO0aJK4hKONOSP4dNG+vU/D92kmJGhgXDwrQ49CPPH6h0tpIEY1+9QDHpJNj/hrISXfFU47hBCn6hGRzMCjkscN+eUTZ0epa2Fc/KXnytSZtNJcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740039246; c=relaxed/simple;
	bh=Eqe/Uvw96JVKBRs26wtSbq8i3q48ATm99ekOa48MCF4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eP3OkaXgxYG8ygSomrls2qBeXT/kORggtbhLN3sh1PGsZ7sEOz3xXXMKOyGKZL7TVFjWW3VG+6HJth0yzRq7nm8GeFoHBZZNokYPyHL7hTmmz5oTubiOU+VQsikp7t/IGtOMTXUq7jBI025XkfZkbSM/kdmAk1q5+1kS0Lcs8tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UiyLPBMK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EACDC4CED1;
	Thu, 20 Feb 2025 08:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740039245;
	bh=Eqe/Uvw96JVKBRs26wtSbq8i3q48ATm99ekOa48MCF4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=UiyLPBMK4DnvdP0CZYEB+uBf6zae+8832jznC2KIn4/Vyo808acimOhvbf0Csn/Tu
	 9rSitKXL6dKPqOpg4A0nKBDsZw3AGks1zBJjuzlwQo2N7txG318eOJ1SfZEmLv1Jwk
	 xOvC8s/tU8wk9cc3wXS8Px3MeNCzhDXo8Bl81ST2sBm759YCgKYyRfwIpfV4mKFQf5
	 JDr86yQH3BlXxolHKlWhomjQt5L4kfXE0xWp+fQhHuyr0gOnM2oaPAekmbw+1QlUXt
	 wvTcsw1PZeT9/opFi4Ey62CRIQsAOl4TTnXXLRa6yb+ev575ZMXUeShUNSTI/z0wkx
	 7R4+fwRttbdpg==
Message-ID: <89f2547edcaaba53d9965cab9133d809607330ac.camel@kernel.org>
Subject: Re: Rust kernel policy
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>, Steven Rostedt
 <rostedt@goodmis.org>,  Jason Gunthorpe	 <jgg@nvidia.com>
Cc: Kees Cook <kees@kernel.org>, Miguel Ojeda
 <miguel.ojeda.sandonis@gmail.com>,  Christoph Hellwig	 <hch@infradead.org>,
 rust-for-linux <rust-for-linux@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Greg KH <gregkh@linuxfoundation.org>,
 David Airlie	 <airlied@gmail.com>, linux-kernel@vger.kernel.org,
 ksummit@lists.linux.dev
Date: Thu, 20 Feb 2025 10:13:52 +0200
In-Reply-To: <97841173-1de8-4221-8bf3-3470a5ac98a7@acm.org>
References: 
	<CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
	 <Z7SwcnUzjZYfuJ4-@infradead.org>
	 <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
	 <202502191026.8B6FD47A1@keescook>
	 <20250219140821.27fa1e8a@gandalf.local.home>
	 <202502191117.8E1BCD4615@keescook> <20250219202751.GA42073@nvidia.com>
	 <20250219154610.30dc6223@gandalf.local.home>
	 <97841173-1de8-4221-8bf3-3470a5ac98a7@acm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-02-19 at 12:52 -0800, Bart Van Assche wrote:
> On 2/19/25 12:46 PM, Steven Rostedt wrote:
> > I do feel that new drivers written in Rust would help with the
> > vulnerabilities that new drivers usually add to the kernel.
>=20
> For driver developers it is easier to learn C than to learn Rust. I'm
> not sure that all driver developers, especially the "drive by"
> developers, have the skills to learn Rust.

IMHO, Rust is not that difficult to learn but it is difficult to
run.

One point of difficulty for me still is the QA part, not really the
code. QuickStart discusses on how to install all the shenanigans
with distribution package managers.

The reality of actual kernel development is that you almost never
compile/run host-to-host, rendering that part of the documentation
in the battlefield next to useless.

Instead it should have instructions for BuildRoot, Yocto and
perhaps NixOS (via podman). It should really explain this instead
of dnf/apt-get etc.

>=20
> Bart.
>=20

BR, Jarkko


