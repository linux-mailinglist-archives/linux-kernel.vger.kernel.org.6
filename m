Return-Path: <linux-kernel+bounces-546605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8737CA4FCC0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3ECA1886468
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6B720D500;
	Wed,  5 Mar 2025 10:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gXW+sONB"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6490F205E17
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 10:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741171705; cv=none; b=HVaHQOYwQuPLmlnpgcG9qIp1XAM4V+iL7FQrsD3geRcCeMyP6p6DOWj/sm+rh1mz/Gis6X4TOMKvtTnKYqXhIKACRM35Hsru/lJL+8f7dkCLF5mGjzEu7F5na+tEW7WiPVlEuAdN99ezothQ9J4jih4DJCMf+08nRvuzMSulZ60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741171705; c=relaxed/simple;
	bh=hN+mTVcW5EZ/CYRPv03zsUPUgV2cXd8F/J1Tc7FdAqU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ZK7NxdoJV6QnQ6juNqqGrzmWOYI0DzHE7mBXaLi/bDfUXVasVSk3rSmQotwr4U6cLMmciO4Py9qfZyh/BYaPranB9OwrnSeoLKcWyQBL2oR6nsI6ZFaBc5Um+NR5ptYLJSxKDoPtgQmghlt16vAnC4snpcBZ19AgmMFbrJJtCZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gXW+sONB; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741171691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hN+mTVcW5EZ/CYRPv03zsUPUgV2cXd8F/J1Tc7FdAqU=;
	b=gXW+sONB/1CmfPPNEMVyeQNyRewRHKhWcc8ToLf7MXTQPf4aaRyf6hpSHI4BBONZVh/KfV
	zRJKHZYm9DGdk7WNpPsxPlwdfsaDQLoIQuGqbUKfFBggiY0sZ0r6BVoIMno3OcBMu1wIQ/
	4bTtju/m4nP+rhIEIjTlrtKg0YHCVQw=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [tip: perf/core] perf/x86: Annotate struct bts_buffer with
 __counted_by()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <Z8gW1rihV0aIp8Oo@gmail.com>
Date: Wed, 5 Mar 2025 11:47:58 +0100
Cc: linux-kernel@vger.kernel.org,
 linux-tip-commits@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org,
 linux-hardening@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <04A79410-77DA-40F9-8904-44DC2DE1E810@linux.dev>
References: <20250304183056.78920-2-thorsten.blum@linux.dev>
 <174111554764.14745.14213573362217486017.tip-bot2@tip-bot2>
 <Z8gW1rihV0aIp8Oo@gmail.com>
To: Ingo Molnar <mingo@kernel.org>
X-Migadu-Flow: FLOW_OUT

On 5. Mar 2025, at 10:18, Ingo Molnar wrote:
> Actually, on a second thought:
>=20
>> - buf =3D kzalloc_node(offsetof(struct bts_buffer, buf[nbuf]), =
GFP_KERNEL, node);
>> + buf =3D kzalloc_node(struct_size(buf, buf, nbuf), GFP_KERNEL, =
node);
>=20
> Firstly, in what world is 'buf, buf' more readable? One is a member of=20=

> a structure, the other is the name of the structure - and they match,=20=

> which shows that this function's naming conventions are a mess.
>=20
> Which should be fixed first ...

Yes, I noticed this too, but since buf->buf[] is used all over the place
(also in other functions), I didn't rename it in this patch.

We could just keep offsetof(struct bts_buffer, buf[nbuf]), or use
struct_size_t(struct bts_buffer, buf, nbuf) and still benefit from
additional compile-time checks, or rename the local variable to struct
bts_buffer *bts and use struct_size(bts, buf, nbuf), for example. Any
preferences or other ideas?

> I'm also not sure the code is correct ...

Which part of it?

Thanks,
Thorsten


