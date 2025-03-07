Return-Path: <linux-kernel+bounces-551250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E09A56A17
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 252EB1767E6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2DD21B191;
	Fri,  7 Mar 2025 14:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="f+YYg3Gb"
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A6E19D8A8;
	Fri,  7 Mar 2025 14:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741356875; cv=none; b=XEanrv4l0hqEjPMXfn8wzMVxvlF6zNKw2JYnqdv4L96zDI4FyxtVLYP6dqQD9WMDmK869EmIWf5235etp3UmwH5Si/o5f17ue2f7+XTjj9fhgCHRXenUTu9kuz78JQcrJElCn8ScNqxv6DOSxzSfwHAIjljjoNSGPnFP8K+V/O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741356875; c=relaxed/simple;
	bh=JuMf/Kv72rI7AK8X9DsnIEf1KkPHWLhdKvwGruCX/fE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ArHfDguP4gOslZsKr4ia+ej+1Y/pag2RYzXp3H7MxCwyqYLyDIU8AfN0mY/6AMDZCOUoQBARdY69qKCz0SDPW3dgXaEGNqof8+BHoljx6212lw7DHe2bP8JZpKpG7cqVhl3bupXNj5jguKBdCymbeL4twOmlSgzPkhJ4aWMY2JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=f+YYg3Gb; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741356871; x=1741616071;
	bh=JuMf/Kv72rI7AK8X9DsnIEf1KkPHWLhdKvwGruCX/fE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=f+YYg3Gbr2qmi+W1m5ZCW+MYze5V/8yJ7aNwCT32TxStzamBpJJ5ibCsHc3PgEtYQ
	 BxFnVBpPr5gKSPTsSDsts04JrQ2u81PvRvALacL6OFAB/A8c4e/YkwNMPMuETGtyRJ
	 yPDDQYYLE/iqQOnf/xznla2BOVwRHXyetHD19Hz/ngtKtLivxPntkBWJFssQCD2ye6
	 m8CCHQFxmcL1chBkW+UnA6MOMndi5klvVx45ZfGOGjx93xtbqjoyhHx5BRYreE1sBe
	 8QaLUajK9fUmO7qpYgfmTM8P3LIhzQBvWYlmeKFXLUAOH4NURjdVIrScWfJ+kTU22D
	 mVe6l7fyUjalw==
Date: Fri, 07 Mar 2025 14:14:26 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@gmail.com>, Markus Elfring <Markus.Elfring@web.de>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 13/13] rust: hrtimer: add maintainer entry
Message-ID: <D8A3HMMRKBUB.3MX3FH3JP8XJR@proton.me>
In-Reply-To: <875xkl3p9s.fsf@kernel.org>
References: <20250307-hrtimer-v3-v6-12-rc2-v10-0-0cf7e9491da4@kernel.org> <20250307-hrtimer-v3-v6-12-rc2-v10-13-0cf7e9491da4@kernel.org> <yjEvEAnF-Dbg6SaNzJ3fl8hPIP9ZNLn9E3q0DsSw82cD2JiGmg9dluQIu_cBTosDty_24DQ2O_XYA4Xvf5T8Aw==@protonmail.internalid> <D8A2IL07RV9S.6RF7B9326WFL@proton.me> <875xkl3p9s.fsf@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: c009b2f142e1a3da55fac18a59b28849603925dc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Mar 7, 2025 at 3:10 PM CET, Andreas Hindborg wrote:
> "Benno Lossin" <benno.lossin@proton.me> writes:
>
>> On Fri Mar 7, 2025 at 11:11 AM CET, Andreas Hindborg wrote:
>>> Add Andreas Hindborg as maintainer for Rust `hrtimer` abstractions. Als=
o
>>> add Boqun Feng as reviewer.
>>>
>>> Acked-by: Boqun Feng <boqun.feng@gmail.com>
>>> Acked-by: Frederic Weisbecker <frederic@kernel.org>
>>> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
>>
>> I don't recall adding my reviewed by for this patch (I normally don't
>> review MAINTAINERS changes, since there isn't anything to review). And I
>> don't find it in lore, how did this end up here?
>>
>
> Thanks for spotting this. It looks like I added your tag between v8 and
> v9, and you are right, your tag for this patch does not appear on lore.
>
> I had some trouble with b4 being too generous with the tags and I had to
> revert to manual tagging. I think I messed this one up or did not manage
> to revert the actions of b4.

I also had that take place in the past... b4 picking non-existent tags
or tags from old versions... I always add my tags manually...

> I'll remove it.

Thanks.

---
Cheers,
Benno


