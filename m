Return-Path: <linux-kernel+bounces-557259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E040CA5D5EA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 07:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 310D7174B85
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 06:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BEE1E3DCF;
	Wed, 12 Mar 2025 06:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUdYp4LJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1331DE4E5;
	Wed, 12 Mar 2025 06:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741760182; cv=none; b=Pi15kkOcTndL1Rb22V9MAwZE/+fF7BPrvJGwbUp0+DrX0Yki9qisTIHedAvqAyZ2DeGRrBn2DI4twSw7iJP062eDKZ5bKP+aLRqbgRaWnlLf6Wu5tVDZveVQ3vpAK0VySTqsBrnkJNo4gVr26LNhqnCYbvEm6GXHI/ZYrKDCJpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741760182; c=relaxed/simple;
	bh=5OIZHiUS41zEorBwAslUlm9u8r3ucK5UHVlhhqJqcTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWFnnMNHqT+2J65Ja2PBeciM49Ub5I9QYpKLpcqSLttI5mNEHwLnGVUoyIKtWNFohYAg+eRbTrbUiYjrqhElomGiWmvrYauOoIMI2zwiKJwYzP3fMwq+mXVAPa2Uh8BQMXQ7OjvNGBcw+vKA3O8JTzRNL8S8IoUIt+7DLBDpFiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUdYp4LJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E398C4CEED;
	Wed, 12 Mar 2025 06:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741760182;
	bh=5OIZHiUS41zEorBwAslUlm9u8r3ucK5UHVlhhqJqcTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QUdYp4LJbwzhdFAOYNKZsahUk4Kc/Qv0XoD8f2i+oN0Sv7AyZmzaofHOYj4dg7wZc
	 68dCpWRZaEKyZ4CJeVKtrDwo+y1qA6wXI19rky0hUPlj7e9y4rLC8GwyaFDwbsfnXC
	 da+4/cEzd+XSXikm9K/YL9bQmfcYnsG67KONbRYeeFQLsugxmGdzTF7OC0aTdg4nEd
	 JK4/Pw+jy11rurEK+HFwbuPsoPVuXyPc7KID7YzVw+rO+3oyWx+dQz8ozzc2gPen+M
	 K/oHl9i0fvNRlyTzHTpnDN3Oh7R8oEE0y4QFUg2Me+UOknV5O8kOqh2TPYwS7OydZW
	 TjFhgOKtEOvKg==
Date: Wed, 12 Mar 2025 08:16:18 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stuart Yoder <stuart.yoder@arm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the tpmdd tree
Message-ID: <Z9EmsiwrbieZWugn@kernel.org>
References: <20250311210011.18b7ab80@canb.auug.org.au>
 <Z9AMEZw1dm80mwx0@kernel.org>
 <affd759b-d84a-4aaa-8de2-812558f1ff49@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <affd759b-d84a-4aaa-8de2-812558f1ff49@arm.com>

On Tue, Mar 11, 2025 at 09:21:49AM -0500, Stuart Yoder wrote:
> 
> 
> On 3/11/25 5:10 AM, Jarkko Sakkinen wrote:
> > On Tue, Mar 11, 2025 at 09:00:11PM +1100, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > After merging the tpmdd tree, today's linux-next build (htmldocs)
> > > produced this warning:
> > > 
> > > Documentation/security/tpm/tpm_ffa_crb.rst: WARNING: document isn't included in any toctree
> > > 
> > > Introduced by commit
> > > 
> > >    115be78c0bfe ("Documentation: tpm: add documentation for the CRB FF-A interface")
> > > 
> > > -- 
> > > Cheers,
> > > Stephen Rothwell
> > 
> > Stuart, could you send a replacement patch and I'll repeal and replace?
> 
> Replacement patch is set.  I just sent v7 patch 5/5.  If you need me to
> resend the entire series as v7 I'll do that.

Yeah, so the build issue needs to be sorted. Also Sudeep's request on
ACPICA feedback was legit. No worries but I'd feel that it'd be the
safest call to postpone to 6.16 and get a bit more feedback before
moving forward.

> 
> Thanks!
> Stuart

BR, Jarkko

