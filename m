Return-Path: <linux-kernel+bounces-250826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E8692FD4A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 17:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6013F2849FA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 15:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF85817332A;
	Fri, 12 Jul 2024 15:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="0+K/iYoW"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFC6171E73;
	Fri, 12 Jul 2024 15:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720797216; cv=none; b=YijjXJwu2lzY4B3QOlxDppCa215EvzO5G3ebEm/ZgWgyxON5mhi6iiZ0O+QfcIBQWF/Uabz7WDLusze5g0YZ921cZMyUE3ETU0E7ST7uFiOKBV4DqM1zpZR5gs5nkVTJcVdOJy0MTlTmUYIqZBf+X26eryAfDwkPQce8SNN0YHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720797216; c=relaxed/simple;
	bh=MnzR0VjdJ5NoBmz1xLLAIhcfaMNgCeiuxKwyJbWLlEo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=f69BuxvnfxGqoITy3O+DUR5q2njwKCjLkck+tZo2FYHlfYKY60M8y4vtgJCsbTXMMQcFyWA/oITVmZCgZc+OcNAasAqUvxvCPykpIDbMKTGEFlnYnb7pLzBfUlfGsYekFZbWkqr+weBJzLxNncKFX17gX7l2w8YxLQJ0zzb1lPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=0+K/iYoW; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720797212;
	bh=MnzR0VjdJ5NoBmz1xLLAIhcfaMNgCeiuxKwyJbWLlEo=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=0+K/iYoW68JAOflPcuy9TwjDOY5gFuRs08GQ7ZhxZCUZQfNvA5gu3AE4peaZhvqsj
	 4ahC/HaLLhZjZKGja1SO/7MXctzd6i1lU5dcEpG69vZe1h2mcSbc4lhRgrtrhgZimE
	 RnYybGCq0zZx/ShTchOJflUXReep6P+UJ5mZEatRdWkeSNMP3Li+HJ7N8iUdb5gmdB
	 Sl2ox1fXBkDWcvD2TjbIdliXkCjxTYCQo1z36XyXY62sW6aHjC4JItDiLB173CV1qe
	 Ld1uhRY9pJwC3GvM1ayCTuVC3TI3lVJblnrP0BS+ittNtDUkCIk3nKCjIEgLH+bDM+
	 lJ85rLPZfHNwQ==
Received: from smtpclient.apple (cola.collaboradmins.com [IPv6:2a01:4f8:1c1c:5717::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: dwlsalmeida)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 250E93780844;
	Fri, 12 Jul 2024 15:13:28 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [RFC PATCH] drm: panthor: add dev_coredumpv support
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <ZpFDeajsuVONbSYJ@cassiopeiae>
Date: Fri, 12 Jul 2024 12:13:15 -0300
Cc: Steven Price <steven.price@arm.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>,
 ojeda@kernel.org,
 lyude@redhat.com,
 robh@kernel.org,
 lina@asahilina.net,
 mcanal@igalia.com,
 airlied@gmail.com,
 rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0A0C1EFC-29A1-4D73-8B02-CC1C693D6A7A@collabora.com>
References: <20240710225011.275153-1-daniel.almeida@collabora.com>
 <fe84a028-01a8-4987-b1b7-141fb76d263c@arm.com>
 <4344B22F-D859-4C64-A351-69FFB5208362@collabora.com>
 <ZpFDeajsuVONbSYJ@cassiopeiae>
To: Danilo Krummrich <dakr@redhat.com>
X-Mailer: Apple Mail (2.3774.600.62)



> On 12 Jul 2024, at 11:53, Danilo Krummrich <dakr@redhat.com> wrote:
>=20
> You could also just define those structures in a C header directly and =
use it
> from Rust, can't you?
>=20


Sure, I am open to any approach here. Although this looks a bit reversed =
to me.

i.e.: why should I declare these structs in a separate language and =
file, and then use them in Rust through bindgen? Sounds clunky.

Right now, they are declared right next to where they are used in the =
code, i.e.: in the same Rust file. And so long as they=E2=80=99re =
#[repr(C)] we know that an equivalent C version can generated by =
cbindgen.



