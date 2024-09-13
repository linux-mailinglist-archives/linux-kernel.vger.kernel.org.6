Return-Path: <linux-kernel+bounces-328528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72718978540
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 17:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 299C31F25074
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 15:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA78E78C73;
	Fri, 13 Sep 2024 15:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="A1syDTUU"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E036E2BB13;
	Fri, 13 Sep 2024 15:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726243002; cv=pass; b=Xv6QWK+hRNFtyBG4h5raZj35vqnJXU8rT7H4+hE0vq9eu4IEAfPr7gcIqKN8/85N9uq3kPQSXXCLmNfKyzZ7qwi5tc3C9OlzXtFEMvD5E+hK2mpCu8rkGYbOS4MPZzTmF23n+1jhiLwS1U9BKVk9aWcsBzgFkvkpZ7RccsAm4YM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726243002; c=relaxed/simple;
	bh=Yqr70NSyZarzCJUv5wwHlngBanuND65KXWPlhwZNvH4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LmDlVv6bHA+4DVzRdxCMLp+P5rJIOFt/mcZJDDWZlNybYaeb1N3ajiMKMJviqmvvzHftsHbCmNk+k0CokEfRIVHiSC+IoIoItPPDnDix/Qc6+tX2Nfr60d/dxYRPuk/QQMClKyxbbwwk2o/WToh4TGXIrhaBQ/fAuuLe4TbZ8Q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=A1syDTUU; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1726242975; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DGEZ/h61AsVo86d7cIuyZjhb9y7hdpqeYyz+fHqK0/MhTiIGwq0OqMiiKiuducN8/DtlSecma7Oz80SfdvV2nB7mqIdJS7Z5V0QXvMNbKSEgN05PlxWFd0GHAtFTaLKpITTflCL0q5cxFIsSVfRaeITV5g1ovEOtRbOzCulpN7c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726242975; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Yqr70NSyZarzCJUv5wwHlngBanuND65KXWPlhwZNvH4=; 
	b=H3SPBhsw7HHDSdseqqJep2loGKLsBCSvnlbtZTEUp3sIsCGIKsb7hXcf+2vGCqNvAqcLj4bQqWm02Ag3hBgOaescRdvzSpz3HExBHMW9qo9hQ3EUJP/MPtH/9DrQ3RAb9B+F6RtcjPqoHukh/sdpX7RZbQrcXh5dLDAdyXNPpKY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726242975;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=Yqr70NSyZarzCJUv5wwHlngBanuND65KXWPlhwZNvH4=;
	b=A1syDTUUXOqGLqFiHymjfQK3Hqj6mynau8H8muPDo/EMQ4YURLps8C+S470U5JYt
	vc+BAeljMZ9Dl1TVgykSauimGuoZf29lVPercTuE8b3osQ9KpdChEHxJqbaCObeanPr
	4rS8GKQjE+RnnBsMngLk6Olw92IQId6LyKcyBiYo=
Received: by mx.zohomail.com with SMTPS id 1726242973337562.6446773823089;
	Fri, 13 Sep 2024 08:56:13 -0700 (PDT)
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

