Return-Path: <linux-kernel+bounces-315006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E0596BC59
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1041F21B2A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5451D9D71;
	Wed,  4 Sep 2024 12:30:17 +0000 (UTC)
Received: from smtp-usa2.onexmail.com (smtp-usa2.onexmail.com [35.173.142.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1AB1D9356;
	Wed,  4 Sep 2024 12:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.173.142.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725453017; cv=none; b=sYRWwqoMnXZiOxyZgTlTwvxRm3eIbqAKR4UTdPuE3ys34WSs+EAbZgjIhSEhp+aWuCxKbC3mRE2cdDvoSlKjGub99vdsuJg8hFtxanAAKU9dLdzfYKXocryG/a9qs6Zlm1GFnzt9BMqXUZm4L21YWqSP5Cf6mc0/L9Cv857Xp/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725453017; c=relaxed/simple;
	bh=sFm2HpUoj2CaPhjOOZkuLbu82utaZ07dktMJYD+N+KE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=mkcre73oTzohCIzR+kNOGqhYHHW7HW1H6uP0Z2zaySM5ZhwqTU4afq/PMVtNQEeTuB9SFX1Lg4bV6QR8vBSrR7ppD/wIGYCgB+ODaV4p6ySVkXx8mR+Cy+JcdDIY72ElQjmHLVJ/g06jBFEekLN/hudv0qevZGgk+9jvUKFJAjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iorw.io; spf=none smtp.mailfrom=iorw.io; arc=none smtp.client-ip=35.173.142.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iorw.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iorw.io
X-QQ-mid: bizesmtp91t1725452913tk5jw6rs
X-QQ-Originating-IP: SaysuuqQVKOz++TcBwpN6cWTk6uo5XmvwZdgQeuDIY8=
Received: from localhost.localdomain ( [203.119.160.23])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 04 Sep 2024 20:28:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 956775205899086131
From: Zigit Zo <zig@iorw.io>
To: stappers@stappers.nl
Cc: anton.ivanov@cambridgegreys.com,
	bjorn3_gh@protonmail.com,
	gary@garyguo.net,
	johannes@sipsolutions.net,
	linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	llvm@lists.linux.dev,
	mingo@redhat.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	ojeda@kernel.org,
	richard@nod.at,
	rust-for-linux@vger.kernel.org,
	tglx@linutronix.de,
	x86@kernel.org,
	zig@iorw.io
Subject: Re: [PATCH 1/2] rust: arch/um: use 'static' relocation model for uml modules
Date: Wed,  4 Sep 2024 20:28:10 +0800
Message-ID: <477D5EA32B25AA05+ZthOusZtXttQOf3B@evil>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <ZtgopAHp+I2+xCIz@gpm.stappers.nl>
References: <20240903130606.292935-1-zig@iorw.io> <FD7D773099A0C7EC+20240903130606.292935-2-zig@iorw.io> <ZtgopAHp+I2+xCIz@gpm.stappers.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:iorw.io:qybglogicsvrgz:qybglogicsvrgz8a-1

On Wed, Sep 04, 2024 at 11:30:12AM +0200, Geert Stappers wrote:
> I failed to match the actual change with the commit message.  Consider
> that ignorance on my side.

FYI, I'm using the master branch of the upstream, but yes it's in the
'rust-next' or other branches as well, so maybe not a big deal IMO.

Of what 'https://rust-for-linux.com/branches' says, maybe I'll use the
'rust-next' branch for the next time, thanks for pointing out!

> I see a problem in just renaming a variable, might be my problem.  Thing
> is that removal of 'KBUILD_RUSTFLAG += ' feels wrong, hence this posting.

I think this is fine, the 'KBUILD_RUSTFLAG' controls the 'PIE' flag for
both the kernel itself and the loadable modules. And yes, that's the only
way I can make the 'PIE' flag out of the modules while keeping the UML
kernel itself works, and the 'scripts/Makefile.lib' I tought has placed
those flags correctly.

What about adding a 'static' flag to the 'arch/um/Makefile' explicitly,

---
KBUILD_RUSTFLAGS_KERNEL += -Crelocation-model=pie
KBUILD_RUSTFLAGS_MODULE += -Crelocation-model=static
---

but that's just a redundant of the already defined 'KBUILD_RUSTFLAGS'.
Have no more ideas what can this flag goes wrong :(

