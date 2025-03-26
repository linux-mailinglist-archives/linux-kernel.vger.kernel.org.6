Return-Path: <linux-kernel+bounces-577413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A09A71CB4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD10016D2C4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C7C1F8691;
	Wed, 26 Mar 2025 17:11:16 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2DF1E868
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 17:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743009075; cv=none; b=aEWEKxASW+Rw24jsNZngoqafHftYAbXVTkWz98tleA5Y3c1CwDAlZDuCZKb+t63PBZ8QlwER8S8iMfuu3z2GLHmrjbsJMdUNgOAcnBpxNNt6Nqgyuxk/h1yLrpsvIPL7gJjSxU8pYAwkvAZ1U6EKe2yABXVKzhoNNHctpe442X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743009075; c=relaxed/simple;
	bh=XV089FtUGuL6aQ7jdpErWbGlqGg/vQXJbrV4tkXm/LA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PRzgGLMTM3OYlnpH3jAEzEo6TD+vpzq5cpRT041iCbUy5TWbvUu9ZDingnnhjW6sBi6x2CDIszXG0MykUWGhDZZUEZrrofhXnbP6ZTTG1H8E45TUEv8esBcDNI7wE4cBoacqD/rNl7rNSnvzIVUrcJES3BdDtTkLJRdwJoUYueY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CDA5C4CEE2;
	Wed, 26 Mar 2025 17:11:14 +0000 (UTC)
Date: Wed, 26 Mar 2025 13:12:00 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Konstantin Ryabitsev <mricon@kernel.org>
Subject: Re: [GIT PULL] arm64 updates 6.15-rc1
Message-ID: <20250326131200.1c86c657@gandalf.local.home>
In-Reply-To: <CAHk-=whwmmU+hv1SyMoyr8yAGP2JiAAP+g5BZaMajzAukzrM9w@mail.gmail.com>
References: <20250325195322.3243734-1-catalin.marinas@arm.com>
	<CAADWXX-0hMgpyeQw_7Ko14hNMciqSnKJAROEWS5vwAdMKUt_zw@mail.gmail.com>
	<Z-NHugcLdLqkEHFR@arm.com>
	<CAHk-=wg_HipugbtswxFnekQy2g_ksKKXj+yht8naj2FEMtRMgA@mail.gmail.com>
	<20250326124025.1966bf8a@gandalf.local.home>
	<CAHk-=whwmmU+hv1SyMoyr8yAGP2JiAAP+g5BZaMajzAukzrM9w@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Mar 2025 09:51:06 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> If you don't see a DKIM signature, it's probably because when you send
> emails to yourself, they never actually go outside your own little
> smtp setup, and never go through kernel.org at all.

Using claws-mail it just uses kernel.org directly, where as my sendmail
scripts use my own server which goes through kernel.org.

When sending to another email of mine (rostedt@kihontech.com) the headers are:

Return-Path: <SRS0=fOit=WN=goodmis.org=rostedt@kernel.org>
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on mailmammoth
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DMARC_MISSING,
 HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_VALIDITY_CERTIFIED,
 RCVD_IN_VALIDITY_RPBL,RCVD_IN_VALIDITY_SAFE,SPF_HELO_NONE,SPF_PASS
 autolearn=ham autolearn_force=no version=4.0.0
X-Original-To: rostedt@kihontech.com
Delivered-To: catchall@goodmis.org
Received: from rostedt.homelinux.com [172.100.189.27]
 by mailmammoth with IMAP (fetchmail-6.4.37)
 for <rostedt@localhost> (single-drop); Wed, 26 Mar 2025 12:13:10 -0400 (EDT)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mailmammoth.local.home (Postfix) with ESMTP id 8EE602014D
 for <rostedt@kihontech.com>; Wed, 26 Mar 2025 12:13:09 -0400 (EDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 60B5A439EF
 for <rostedt@kihontech.com>; Wed, 26 Mar 2025 16:13:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5492CC4CEE2
 for <rostedt@kihontech.com>; Wed, 26 Mar 2025 16:13:08 +0000 (UTC)

So it definitely goes through kernel.org.

But it has no DKIM headers.

-- Steve

