Return-Path: <linux-kernel+bounces-328529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7665B978541
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 17:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B0781C2149B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 15:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491A280C13;
	Fri, 13 Sep 2024 15:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="U+9AU8Oy"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC197D417;
	Fri, 13 Sep 2024 15:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726243005; cv=pass; b=SlLVvWWluSYBxaTGdRLyOMk7vgbdg6mPnOqhy6oHtc+qajEkY+BMDPFV1sltk9OGyN02ZmoYumEertCypZh8lDNvAQ0GhWOftORvZhK6QSee8kGsGHMQGp+Iz6YUNkYFNw/CvTRVZUfgdOzrPEUVBNpfKMii8cuFhY7xv1gCm2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726243005; c=relaxed/simple;
	bh=Yqr70NSyZarzCJUv5wwHlngBanuND65KXWPlhwZNvH4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=D/sXwVwz9Ozj//kHWpkoq5z0vEa3lcw/txsf9oFHz2xYS9Wtsws90EwWXrO1ZcQlTPmscuPI4Ty1uB9vWNM2dPl3rqsUH8rRGGIyBoj6mAxd0VThDsd/nZym/0NDdeAFehbwykopjtShGXDJsgnp81o2iOl51MGTYLbT3VHhz1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=U+9AU8Oy; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1726242977; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TDE+SO04G9tHxkvJJWiCTAW3B9z3UFss6uStMBIkgh5KK9loLzg/1JWMXXWHH2YnXiOF6pTD3TzLgkaYKLbYCm3niTumC27yDrt2SbCRvfAzZwj2iJCc2/WE2IgldUqpmaEDUA2UXy/iaGWIaCGWulYqGB0yNDXu3EJzomvOF5w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726242977; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Yqr70NSyZarzCJUv5wwHlngBanuND65KXWPlhwZNvH4=; 
	b=jjdqaasEZeQgW5PTukYRWn7eYkW8f7yT/dIuzguCT1CJpmESL0h9BZapa5cbtXBSaiR3bdpsoT4sMnvcYlR4Z79EZ5pP/e97DyTMih/mNiV/qQR3aLwDzdfByvI4piA7OOncU5soyamKZMq/Lq7g9ZaHwXw26Hv8oLNKqxyM/pE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726242977;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=Yqr70NSyZarzCJUv5wwHlngBanuND65KXWPlhwZNvH4=;
	b=U+9AU8OyesXcIrF+KP/TuvuGFIXO9wnt49GrQXYahd2MUPsKapsMr1MFBos1v5Gt
	1Ye8kxgJJ+82w/v8dS9AJCzBYYBKPL3hsG6U/gtCa+LrYK/crfYNv4ouKmOI6XMceiR
	cDjgcZmG0rd7MogN6qLSsbF0KDgl/F0uy8wSv0VE=
Received: by mx.zohomail.com with SMTPS id 1726242975813602.3442581402895;
	Fri, 13 Sep 2024 08:56:15 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH v5 0/3] rust: Add irq abstraction, SpinLockIrq
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20240912190540.53221-1-lyude@redhat.com>
Date: Fri, 13 Sep 2024 17:49:58 +0200
Cc: rust-for-linux@vger.kernel.org,
 Danilo Krummrich <dakr@redhat.com>,
 David Airlie <airlied@redhat.com>,
 Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>
Content-Transfer-Encoding: quoted-printable
Message-Id: <35F8F5EE-16CE-4EB7-9775-A23EDC2C4C71@collabora.com>
References: <20240912190540.53221-1-lyude@redhat.com>
To: Lyude Paul <lyude@redhat.com>
X-Mailer: Apple Mail (2.3776.700.51)
X-ZohoMailClient: External

This series looks good to me. Thanks for working on it.

=E2=80=94 Daniel=

