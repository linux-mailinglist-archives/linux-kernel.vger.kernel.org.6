Return-Path: <linux-kernel+bounces-317780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEB196E3B8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 22:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D065B22D1B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 20:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B587A19AA5A;
	Thu,  5 Sep 2024 20:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eutQ9xFO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qGBfmjA9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88B01953A9
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 20:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725566985; cv=none; b=k31B4lfdkuvItIIHLrRcq03bCFltZ1B1g3cS63+6p4zp/2aSphrUBUk90oxeU140dNT+NGH6Q3fq10gWtsElUW+uW0KCh2IVKphHd+EDQzsWhi86GuxSHe0NUZija5FzoTQA4kTmUFVq/a0mgCii0LhByhJr6DPAvTaaJtfHTqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725566985; c=relaxed/simple;
	bh=Wn4urdgI/XdpbjhcOnh4xQcKxiiY4lHaJa+xUfzpnu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ViHWbDRe98CSzWbVemDJ9IVd5fofrk9pVcWudR6K4Smq6kSWhOnFAfeKuSTgusgBPITzlolBA3HTPuvv8dxQCUyjnfsBwoAEug00Lf8ZbSx3jxGxJcgOz5QfrFCWS6WhePpKocglH5Z88FnbY3x/Plv5bd5N0fltP46JwgzadGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eutQ9xFO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qGBfmjA9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 5 Sep 2024 22:09:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725566982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w44uL6VHwM/DHK+ASTNjrJOWh44/UrWkNKqJ9v2M7zw=;
	b=eutQ9xFOhWc+xf8lWfFJ8kpCNREV3H2n40OvHZrt6qSeC3IUIdBYwf8cZnUe+8EGgSsKk5
	hr3fC2BfrmJegUI4kMyo8FKzTUmUvZDcecQTJ6a/fRTgVrc8Q0g9ZKXHLiFj1ggXHzmCM9
	Nw/AcUcoom0WvaNEJRCHlKiiKe0vDJlFJj6ZobXBWR2K4yLX/JhrZ3Rtjdw5RiaSjZBBzt
	RzsdiS+b1zg4tHmAnbBPjE0VzMQKnHN2eXPeBDXriOj8pHx2QgkNb8O3/gXJSnRPGoANL1
	g+K8Coc55kWquKcjgtZwdY5ecdf/cgrZ+xNg+arVJeFJQUrE9t7eDL/O7YvLmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725566982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w44uL6VHwM/DHK+ASTNjrJOWh44/UrWkNKqJ9v2M7zw=;
	b=qGBfmjA95KlR7ru4HDwXgLIhNBAMUQ4SD03exNrgB7dqn4z+AsOtd+oHRKCcFUs7VNA+HI
	fi4ZTvMs3IwdgrAQ==
From: Nam Cao <namcao@linutronix.de>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	bigeasy@linutronix.de
Subject: Re: [PATCH] x86/mm/pat: Support splitting of virtual memory areas
Message-ID: <20240905200940.nFdZ_cEX@linutronix.de>
References: <20240825152403.3171682-1-namcao@linutronix.de>
 <5jrd43vusvcchpk2x6mouighkfhamjpaya5fu2cvikzaieg5pq@wqccwmjs4ian>
 <20240827075841.BO2qAOzq@linutronix.de>
 <yvcwdfgxnyet7rjf6lhnsypz72jmp5czfkb2muvgzcul53scn6@rkhqrfgdaxsw>
 <20240903103616.i0GrRAfD@linutronix.de>
 <lfvhfjj2ysuut7sawru6aoywjowpsba3z2t56pjxh5tbi7kxfw@h7twfxw5oalf>
 <20240904075937.xh2rLk3q@linutronix.de>
 <jv6v6bgvh2uidqqeava72pjh2d5uehtyim74r3gatxn6v2uebh@t3lbrkhh6fzw>
 <111407dd-3628-4cbc-91ea-a1c31e27ed2b@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <111407dd-3628-4cbc-91ea-a1c31e27ed2b@intel.com>

On Wed, Sep 04, 2024 at 02:29:47PM -0700, Dave Hansen wrote:
...
> Nam, I didn't see your original patch in my inbox and I don't see it on
> lore either.  Is there something funky going on there?

Broken email setup on my side :(

My future patches should be received correctly.

Best regards,
Nam

