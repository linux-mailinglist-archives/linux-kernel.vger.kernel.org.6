Return-Path: <linux-kernel+bounces-418633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 386E59D63A4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B52E4160FA5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E8E1DED42;
	Fri, 22 Nov 2024 17:57:16 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE49175A5
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 17:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732298236; cv=none; b=CW2RlH9kdpNUXzJmRo/sgpfV147xbVX2HLBYmpq/PY6i96aNkWqO5o8ab5m1uyT4HyrbuK9cMyRNZmVOlWy6zpmVSRPUTAtwSsd0l3x0m+HmLinof8sJjWQN4q2g+aH4n9U+DITW55+I5rpR1sZMq7W9DLX6+kwwy6KW1e7tIEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732298236; c=relaxed/simple;
	bh=LNlnTbsbMJIug7wkwcj+iHZaljPvfEUM6mty+m1RhaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAFyX7pTgiDvH4CaI/8IRdDBni0UYHJuGMRpHuc7xI1T9xjer3kU0dliBv6IPHDq1/UOTbJQngXlFqld4CZfqx1+QCKiFoBC4H/VkFAyOZwB7vHXDI6XGPQpnzypwB2ri46qKaedo+Cqp4qBJ1rrKZ1v7B2dq9qqMDvERxefeSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87897C4CECE;
	Fri, 22 Nov 2024 17:57:15 +0000 (UTC)
Date: Fri, 22 Nov 2024 09:57:13 -0800
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] objtool: Collapse annotate sequences
Message-ID: <20241122175713.zxtwuz77ppjcotg3@jpoimboe>
References: <20241122121016.372005127@infradead.org>
 <20241122121556.447242540@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241122121556.447242540@infradead.org>

On Fri, Nov 22, 2024 at 01:10:24PM +0100, Peter Zijlstra wrote:
> Reduce read_annotate() runs by collapsing subsequent runs into a
> single call.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20241111125218.921110073@infradead.org

Stray link?

-- 
Josh

