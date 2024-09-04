Return-Path: <linux-kernel+bounces-315813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8E196C749
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 21:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 683A4284C3E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5CD1E6332;
	Wed,  4 Sep 2024 19:14:34 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487EF1E6325
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 19:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725477274; cv=none; b=gRjicSzvUhvOejIxakw68HLG9XvSTfcKrXjfuBKi+zGxhOud2zce5VMWB26uSQd2cIS8q19TsNqw6CcHQevlgw1YfAO3Nn124GDlUZRLmWjaZ50hYE/m0RYyimk/cN0yDBXqLuWtuYIMMBbvG87d1V+yo6bhH4WssOqUHO1PqLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725477274; c=relaxed/simple;
	bh=6YXYW+JWcdfT8KRajoNMTF0wP0WIF4QyGLC9QwAcHek=;
	h=Message-ID:Date:From:To:Cc:Subject; b=F+Er7K6eZ64i22xHnswWNWDQ7pgtgVaN9aLlRg71soK7F3I9s2vMpyzoY4Yffrdn+5O7am6R5LlN/DNpBYmyGhw3NFke7RV3UkcYWn+Xe+mQWUWsDth4cHw274tW2/vFhgE23Lo6UvARFQvZO519CSlipw9ALLgqDoaRVvZ9xpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3486DC4CEC2;
	Wed,  4 Sep 2024 19:14:34 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1slvTb-000000059D8-2BcD;
	Wed, 04 Sep 2024 15:15:35 -0400
Message-ID: <20240904191514.942314784@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 04 Sep 2024 15:15:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: "John Warthog9 Hawley" <warthog9@kernel.org>
Subject: [for-next][PATCH 0/2] ktest.pl: Updates for 6.12
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git
for-next

Head SHA1: 2351e8c65404aabc433300b6bf90c7a37e8bbc4d


Daniel Jordan (1):
      ktest.pl: Avoid false positives with grub2 skip regex

Steven Rostedt (1):
      ktest.pl: Always warn on build warnings

----
 tools/testing/ktest/ktest.pl | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

