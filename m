Return-Path: <linux-kernel+bounces-418564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF2F9D6300
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 962651614A8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482101DF98F;
	Fri, 22 Nov 2024 17:22:43 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB898154BFB
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 17:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732296162; cv=none; b=NFV9zHT/DK+G01O1Acaf6OHM/yT3ef52jB8ojS0A2Ut8MKTzalNKCftQU3zTH9MQrzVUMU8WA98p+0drWpR3hOxqR5A5mad2Uebi5ZcUrXKgER73IyJKty/ucfqjgk/CCA+NKMa/cunEVilLJQ5SCOfrCykQALrFeO1+UXf5xBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732296162; c=relaxed/simple;
	bh=6+DBKln+6XPlGVnZINqgLwtt9qRjpX7RLyX64z22EFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qU3NO+cRI62emkAmETKUC9M+fKTPOC/DmPN368YzbIL16Yb6ZGY5QNlfU93TiVAvpsH91X8V2VB6e2/svNG6dh7cjPfAVhHGy6L/qdw98uQABKuP9eEUiYVLPtMg247jJ0dGDws8ydVZV8lEhDKDXpCt8isy2eUcF2bJB6qUK+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B05C4CED9;
	Fri, 22 Nov 2024 17:22:42 +0000 (UTC)
Date: Fri, 22 Nov 2024 09:22:40 -0800
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] objtool: Convert ANNOTATE_INTRA_FUNCTION_CALLS to
 ANNOTATE
Message-ID: <20241122172240.76qplflitbvb44nc@jpoimboe>
References: <20241122121016.372005127@infradead.org>
 <20241122121556.315596549@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241122121556.315596549@infradead.org>

On Fri, Nov 22, 2024 at 01:10:23PM +0100, Peter Zijlstra wrote:
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

s/CALLS/CALL/ in $SUBJECT

-- 
Josh

