Return-Path: <linux-kernel+bounces-571300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3DCA6BB78
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C4363B152D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD691227EBD;
	Fri, 21 Mar 2025 13:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="EMELKBL8"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C51B22ACC6;
	Fri, 21 Mar 2025 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742562653; cv=none; b=P5V3ixbw+N8GYs/2pIch0TDp6NL5Psp9jVxsLOxUDurpColMi7VSwqijCCSmilzWHEIHv+SOX1cSZwt/nAuA5pc7bXfdBUwieJuAgF869Txga09ZlhWhcAbDwyNBJXZx3UnGIHI2adcT9m9joh5O8/px4d3j8oKHwHdKvUEekBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742562653; c=relaxed/simple;
	bh=gyxfuz3biyX/j0JM6faVvSVxFfuTvlSqD8bchmBZM5Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UUnJAELXCRsZ6vO79Borj3OuK5qtFM898KS6dJnBGcIartMXZFIe3kWho/5UvT0pKoeIMzyb4uUdQBd6WFW59yheNrEGb2v5vyDxz3iqDerwEvxIJ+ITF7J0W9NNEMGq2bOUUNUNSRyMSKpuC1z2gJ0LVfRUH6GfBfTmSXaZgM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=EMELKBL8; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742562649; x=1742821849;
	bh=gyxfuz3biyX/j0JM6faVvSVxFfuTvlSqD8bchmBZM5Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=EMELKBL8/SGvy8hoXif+WYGKhj4Et1CiKweY1a4gVLvYHEiz8h7GErZauSOyeLqfe
	 YAxOJ5ZLwAPXVP5AOKUVfQTTI4GjbkMXTN9quh8qxj+zh8b9t6hXNG8H9IoMYlITh7
	 aV7++qwTdLO1j5btGvHq2CCLsu/Q9RuZ48kW947tale0BZqB3dz/gX3bIB+Lx9U+an
	 Brb1NgMf+xbCXjdVLivcAjWhvoiuQG5JI/VCo+CgGSEw7068ZIokVBxbKJDZrh1MlX
	 gJ1GJSS0HbnkmQR4vzF2z2deevzyuNahBtpfN2Tg5oR071pI/vfv3gC4Wu0QKeMEno
	 471qmkRMF0MzQ==
Date: Fri, 21 Mar 2025 13:10:43 +0000
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Matthew Maurer <mmaurer@google.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
Subject: Re: [PATCH v2 0/7] Additional methods for Vec
Message-ID: <D8LYWIFUVJOC.ZIPANZF9ONJJ@proton.me>
In-Reply-To: <Z91au1h1zhDT9IxQ@pollux>
References: <20250321-vec-methods-v2-0-6d9c8a4634cb@google.com> <Z91au1h1zhDT9IxQ@pollux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: dd867d54f4fcedc4ea50f2cc667bafddde2aa966
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Mar 21, 2025 at 1:25 PM CET, Danilo Krummrich wrote:
> On Fri, Mar 21, 2025 at 12:09:55PM +0000, Alice Ryhl wrote:
>> This adds various Vec methods. Some of them are needed by Rust Binder,
>> and others are needed in other places. Each commit explains where it is
>> needed.
>>=20
>> I'm not sure what we concluded on the set_len / dec_len changes, so I
>> don't depend on that series for now.
>
> So far I see no reason to assume otherwise, so it probably makes sense to
> rebase. Unless Tamir is fine to rebase his changes onto this series.

I haven't yet taken a look at the reworked version of dec_len, so I'd
wait until we have finished discussion on that.

---
Cheers,
Benno


