Return-Path: <linux-kernel+bounces-537170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D30A488D1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4892B188FEAE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79E726E659;
	Thu, 27 Feb 2025 19:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odpBTL6c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3359827005C
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 19:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740683768; cv=none; b=OeI/oCkB4N+U7RBiqnLRdGbyol0Ct9t4FKRAOhYIfyfp6uxfXMRC8IgIQk6ftvBBYogtx/HW7fW0sMzpcTXjr0jwUeF7KwYORBD1M4ZbZfUhvGjTHlbg4TXBcdkRpnpwstAqf41tlWBwTQNjybpbTDSXGDRtuhzOvlwV4+c1HEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740683768; c=relaxed/simple;
	bh=v66HyVb30HGGLg9kKQ6/DG7AiHUsKM2ZRI/mlwwjpVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USZJtR2V65kYCbDCw+9XSVsNW3HSNv/jX+sy5IiD3nvEwljKuZvCtKFk9YhDrJFVTCTC1zaGAz/hB1ef1Osv+Iq4mcMlDp/B3d2E3pzQMm5sOAiPOlYtvIiLkpB61phiClSCHl537OD02rxHerce/xOqWqTf1G3AeJkssJtz0SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odpBTL6c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A50C4CEDD;
	Thu, 27 Feb 2025 19:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740683767;
	bh=v66HyVb30HGGLg9kKQ6/DG7AiHUsKM2ZRI/mlwwjpVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=odpBTL6c19YiBCH9yzS5EtsykIlOSL8TewBy8KyfUMJPu+h004pBbPcPqaSHirIpk
	 CJkpCYqdMxgmTKa9GMwYhITYuenXWAaY320EKtLJNkfC745pVGkErKzUrQmN3VUvM+
	 837obixdDgU16cW6Xh/BYFqxtmlQEUgYgYUPACMY56s3WQ6s+7+y65MbJfc3KEPjVE
	 EEVU7ZGttSDeYJGbidRZzh7o+eQ1i6saTmv40oQLk8h9Hx2GVCwOp5scbaZX2tg+M1
	 7zRAysdTauKEtqcrwinUGhKDCO7EKDZeSdYypnwpWVjj2JL6qRJ+YpbvFgJ0qXY/pp
	 aGctZDikjTuqA==
Date: Thu, 27 Feb 2025 20:15:58 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH RFC v1 00/11] x86: Support Intel Advanced Performance
 Extensions
Message-ID: <Z8C57rzRt90obAFg@gmail.com>
References: <20250227184502.10288-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227184502.10288-1-chang.seok.bae@intel.com>


* Chang S. Bae <chang.seok.bae@intel.com> wrote:

> == Introduction ==
> 
> APX introduces a new set of general-purpose registers designed to improve
> performance. Currently, these registers are expected to be used primarily
> by userspace applications, with no intended use in kernel mode. More
                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> details on its use cases can be found in the published documentation [1].

I strongly suspect this won't remain so, unless there's some horrible 
ISA limitation or other quirk that makes APX unsuitable for kernel use.

The moment one of the mainstream compilers adds support for it we'll 
want to enable it for the kernel too. Since the new GP registers are 
caller-saved they are fairly easy to use as scratch registers to reduce 
stack pressure, which is very much present on x86-64, especially when 
the frame pointer is in use.

So we need to keep that in mind when shaping these patches.

Unless I'm missing something that is. :-)

Thanks,

	Ingo

