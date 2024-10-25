Return-Path: <linux-kernel+bounces-381610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E5B9B0188
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 13:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F52D1F22781
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 11:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0B42003BC;
	Fri, 25 Oct 2024 11:44:05 +0000 (UTC)
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4531C9B62
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 11:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729856644; cv=none; b=lera9RW9h+AVNKdGh6cdXsbLHzi++QUubgdIdu5TW+gjPdKxMJlNlmgfa7/NNw6ko9CwvqrID96ttD6gXwA+FtWjQ34pQW/uNSQTGnie7VtNaJNdw6kUvrRcMPWO4fLcKuRx9FZ07QXuGGPVq7HIOgb6rmrhz+elj3azzMUE3Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729856644; c=relaxed/simple;
	bh=gsN6W5fDUXZ03huDxjBlEwiY1UfaHdn6PeY4sGtQq+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WU8nMO1MGlgTvJ2xA7Ge3OHETL0tBMrHWqVkpsDkXQJ3MbMCPQzFabn5R2dQaF2CyS+aJ8N+9awUiDV+pfFO307h0m5n7CgA7hGi7LavVpy0s97N4KkDv43ul1MdHQ7IRdiOiDTV+eURgGQ1XuQDYZyg5GU3xWHXkGkqnH5ZjLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id EA18472C8CC;
	Fri, 25 Oct 2024 14:43:53 +0300 (MSK)
Received: by imap.altlinux.org (Postfix, from userid 705)
	id E6A0A36D070D; Fri, 25 Oct 2024 14:43:53 +0300 (MSK)
Date: Fri, 25 Oct 2024 14:43:53 +0300
From: Michael Shigorin <mike@altlinux.org>
To: NotYourFox <contact@notyourfox.coffee>
Cc: james.bottomley@hansenpartnership.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Subject: 14071 | Re: [PATCH] MAINTAINERS: Remove some entries due to various
 compliance requirements.
Message-ID: <20241025114353.GA15332@imap.altlinux.org>
References: <7ee74c1b5b589619a13c6318c9fbd0d6ac7c334a.camel@HansenPartnership.com>
 <51b4a9dc-42a8-4d3d-bd1d-2a5548bdc5b1@notyourfox.coffee>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51b4a9dc-42a8-4d3d-bd1d-2a5548bdc5b1@notyourfox.coffee>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Oct 24, 2024 at 09:41:25PM +0300, NotYourFox wrote:
> Thanks for clarification.

There's another one: some lame duck's Executive Order 14071.
Which IS "the US thing" contrary to Linus' "explanations".

http://youtu.be/L5Ec5jrpLVk

Wish the US folks recalled Executive Order 11110
instead of diggin' their own grave as ordered
by the most real nazis on this planet.

-- 
Michael Shigorin
http://altlinux.org/elbrus

