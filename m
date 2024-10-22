Return-Path: <linux-kernel+bounces-375603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 347499A9812
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 06:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3AB01F240B0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 04:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A9C6F066;
	Tue, 22 Oct 2024 04:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uoKk0iLP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B06384D12;
	Tue, 22 Oct 2024 04:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729572897; cv=none; b=DnPTJgtqpc0beis2juraFsIX4NJptNtifZpvrW9LBYKKibB70lz0KXyJ2f4i6HaxY9DcXHRXW2VJX1tcmuQY8kbLQv5UYdbAmzhQ6Dmgbx0CSjxioAyr+HjBLvH8ZjJltjwradi7gfJvhU/GUOzFSB/kIC2ECttrDoj67a/+HYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729572897; c=relaxed/simple;
	bh=Rg3jB1KUu3XeJP2mAoDRzVSH/rz4K/4b/bxmVMIHKks=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=hxYd3n4VvoAq+It3A0/htGqLUKdGYM0YYmEjNSPXrqdcDqXJFDO6EqV/MtwsZrgLPqsRTj5KquYCt2upsiJGZI5sGJJZOrXo7rRv/2q287nj5nwhN6O/dj/TJcPoDbaQKqL31Tp+ddDlSENCy9qoPJg2VlbwUlpDnopHNrwJt1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uoKk0iLP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC3EC4CEC3;
	Tue, 22 Oct 2024 04:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729572897;
	bh=Rg3jB1KUu3XeJP2mAoDRzVSH/rz4K/4b/bxmVMIHKks=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=uoKk0iLPuaeFI3qxBnug9MizLCRR2+0OgUO5cRhuaVbrFMxuyE0bI3NAKI0DIHLa3
	 vUxBgVi8crkKHBSxC7+p+G1oT/MJ84Db/8XIjRYne6mim3IrRZL5vvK/rvHHlt3Xdu
	 cayyLiNZIDxdswtTQ1idN+4rKjjNGZjkQB3q+wgt4X1Sms4F7Y+wV9NN93+v5gdBt4
	 3fShg2F67HmzxOGLt+jIkuQqSSP3q+IwwHdc8xf0iOmV/UUILDEXUeBqd6xdr4V9vS
	 klW9040RgddyzQCbmtPppSDuDgJoENEV7uzOorcSO6YO/16V/+qoavPKW1rGIxPeh5
	 vb4qNIfK/B6RA==
Date: Mon, 21 Oct 2024 21:54:53 -0700
From: Kees Cook <kees@kernel.org>
To: Sasha Levin <sashal@kernel.org>, torvalds@linux-foundation.org
CC: ksummit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_linus-next=3A_improving_functional_?=
 =?US-ASCII?Q?testing_for_to-be-merged_pull_requests?=
User-Agent: K-9 Mail for Android
In-Reply-To: <ZxZ8MStt4e8JXeJb@sashalap>
References: <ZxZ8MStt4e8JXeJb@sashalap>
Message-ID: <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On October 21, 2024 9:07:13 AM PDT, Sasha Levin <sashal@kernel=2Eorg> wrot=
e:
>In an attempt to address the concerns, we're trying out a new "linus-next=
"
>tree is being created and maintained with the following characteristics:
>
>	1=2E Composed of pull requests sent directly to Linus
>
>	2=2E Contains branches destined for imminent inclusion by Linus

But this means hours or a day or 2 at most=2E

>	3=2E Higher code quality expectation (these are pull requests that
>	maintainers expect Linus to pull)

Are people putting things in linux-next that they don't expect to send to =
Linus? That seems like the greater problem=2E

>	4=2E Continuous tree (not daily tags like in linux-next),
>	facilitating easier bisection

I'm not sure how useful that is given the very small time window to find b=
ugs=2E

>The linus-next tree aims to provide a more stable and testable
>integration point compared to linux-next,

Why not just use linux-next? I don't understand how this is any different =
except that it provides very little time to do testing and will need manual=
 conflict resolutions that have already been done in linux-next=2E

How about this, instead: no one sends -rc1 PRs to Linus that didn't go thr=
ough -next=2E Just have a bot that replies to all PRs with a health check, =
and Linus can pull it if he thinks it looks good=2E=20

For example, for a given PR, the bot can report:

- Were the patches CCed to a mailing list?
- A histogram of how long the patches were in next (to show bake times)
- Are any patches associated with test failures? (0day and many other CIs =
are already running tests against -next; parse those reports)

We could have a real pre-submit checker! :)

-Kees

--=20
Kees Cook

