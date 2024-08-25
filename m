Return-Path: <linux-kernel+bounces-300593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D140295E59B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 00:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FC5D1C20B74
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 22:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D527829C;
	Sun, 25 Aug 2024 22:48:53 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCF37441F;
	Sun, 25 Aug 2024 22:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724626133; cv=none; b=T/ITDBv2aogAC9edFBel8QqdBZMrJHxuDMaSRHH4LeAPS94jnB4T5EaNXbftdgt1mZ6Dh51738eh91thpIYoxsCQx3p2RTnv+I8kXTvVPRT2KIwKdJAVBUHeR1Pc6uwNxqzj99fGpcxuckloWrIWb1IiQIwqWquy+6bmmhvXEIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724626133; c=relaxed/simple;
	bh=Y7ukIYgyj34kzicFN2EZfCkb7ApWgS8GHa754G33Y4U=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=TYTIU1tND3cjvuJnPiyaqnhDHZitwsI5dZE1FiilWaxwpxKVWCPeX3/4qJ8sK1xGUMYnuZ4WQ8GrbNIlyJmRqRwzf/5mevrue6mr3D1aNENyqT23vuFtUujfLCIbyngrs5Z7116PsogVY8tDcaZ+DGVJq73IAIYdEdxcVOEmBfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id D9FB91A0913;
	Sun, 25 Aug 2024 22:23:43 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id 5B0F22002D;
	Sun, 25 Aug 2024 22:23:42 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 25 Aug 2024 15:23:42 -0700
From: Joe Perches <joe@perches.com>
To: Siddharth Menon <simeddon@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org, apw@canonical.com,
 ojeda@kernel.org
Subject: Re: [PATCH] scripts/checkpatch.pl: check for non-permalinks to Zulip
In-Reply-To: <20240825221806.253575-1-simeddon@gmail.com>
References: <20240825221806.253575-1-simeddon@gmail.com>
Message-ID: <f53fa069b9cc24a9552d54c7a004fe6d@perches.com>
X-Sender: joe@perches.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5B0F22002D
X-Rspamd-Server: rspamout01
X-Stat-Signature: 4u3wmiyokw19s98z8c6a187d5asuaawq
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+zkfSnsJQ/IQVGjMyf8RVvtKgtLwQY73c=
X-HE-Tag: 1724624622-984051
X-HE-Meta: U2FsdGVkX1/jFxYIqeZdH/Q4MB9o+hq2lLr9McUno24VaQBukcDvQ1MY6TV/YHHluxikW2Ink5Xu+kTTMBjFcKLe1XQhVjeNfdgLkMheoDQXb4W5FJ4KdL3YdgWJTLgfzGhylL2/E1GtNRKXXfiVqceEDd4IjKqPFrl82r+2GM6A4/mqN6GnAKvP4NjPVTFVay7tOHissn79pL7S+tcKvm9V7ZQ295uJdYcBinK0pFMGwSDPBsPHXb6NYhSRZ5NTklucqoKFKIF60qD9gSGjR3EyXmwqhFWfAcyuS+gUG15oBh8XRtJW+RTAsLq1kASxc/HaAwzTv93ZFUDzVonINg==

On 2024-08-25 15:18, Siddharth Menon wrote:
> Zulip links to https://rust-for-linux.zulipchat.com can break in
> case of renaming the topic or channel if they are not a message
> links (which are permalinks).

Why should these links be used in the kernel at all?

