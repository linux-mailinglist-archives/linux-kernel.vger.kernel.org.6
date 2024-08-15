Return-Path: <linux-kernel+bounces-288703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA9C953DCF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 01:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 762B428BE81
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 23:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5ABC15532E;
	Thu, 15 Aug 2024 23:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QcsCpgwr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0912A12B94
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 23:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723763044; cv=none; b=rrcpsqu4P24fk/t+xyIYYsa7Fez6MuLH2eSwH1foy5JS+M5QHwudnNMItR3PFWiJ3TtAjK+gm5MoIzTcKA68cFIy9zE0crTxqv6BL/6htyBslptLt7+J2tLnzFlb4ONF8smStind1A81u18BlTaAt6+S0qDtc9/G1HGj3iTYHQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723763044; c=relaxed/simple;
	bh=g/LuiWafkFQeYDFjUHI5HFxVs5ruAR+ntKYFcpTb050=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=l0QahZ4qQWbVZ7zuK8wmj4w98EPt0aq8J+0HxITNRucgHAvFMMtgJgQQZ0/xIkjHGTLg1vti7EE4UjiqV7JhFoYTgh5DLe+R8qsQaiHVg8j4Hh1B9pCqEhnSIPhJNuSorx6Y5cX6bzNOSte8QLP5YYTN+CKlW2hIZOJOIucCAoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QcsCpgwr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B09DC32786;
	Thu, 15 Aug 2024 23:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1723763043;
	bh=g/LuiWafkFQeYDFjUHI5HFxVs5ruAR+ntKYFcpTb050=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QcsCpgwrn0irlJu99NNmVfR5HDJyDLN3avGak158HaR+dfRxhvqOYrwO87kn16fJd
	 fGnzG8/9wLhwMW2Lqb3fTTXtzBMtA2MPZhg+L5n1sGMtCnROgQescE82MRqbzlJJK9
	 UFCkKvBh3WffIg4CaKWVaoqS+h31QJMOfjRtAWfA=
Date: Thu, 15 Aug 2024 16:04:02 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: kees@kernel.org, davidgow@google.com, kunit-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, erhard_f@mailbox.org
Subject: Re: [PATCH] kunit/overflow: Fix UB in overflow_allocation_test
Message-Id: <20240815160402.a4c80b075082f537853fe2d0@linux-foundation.org>
In-Reply-To: <20240815000431.401869-1-ivan.orlov0322@gmail.com>
References: <20240815000431.401869-1-ivan.orlov0322@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Aug 2024 01:04:31 +0100 Ivan Orlov <ivan.orlov0322@gmail.com> wrote:

> Subject: [PATCH] kunit/overflow: Fix UB in overflow_allocation_test

What's "UB", btw?

