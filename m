Return-Path: <linux-kernel+bounces-218424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB5690BFA9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 01:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76A301F22DC5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 23:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A030199EBA;
	Mon, 17 Jun 2024 23:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+vC9QNM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8117419A28F;
	Mon, 17 Jun 2024 23:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718665914; cv=none; b=UQqq9qbopi3xp/B8wdsVlW2p4ywI/I5bvLplIxNLP4Lwz1HvRuTj9l8E6mqLhJsVo2wpZgubn6u81aCGWxr5Fkm2QJn96HnpPTuo4Tju2LdodFg8V4cOdfSWA6VbrRUze9WW+t+b7gRiD2+kTtRU6EUEb6DxB8LtI/124QCVNa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718665914; c=relaxed/simple;
	bh=bpeQJSd0BsKdh9O1L/WBzXi7cm11ewlcZk3ruc8dtR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eiGP+29wbrZVAyKwW4FfO3NYRq78awTgbgzFtHlHzK5zolbCFD2+jzv8nXMIkRqtptIICJAiamq1o+uhH9uEMYDck+PSzTrNRmWDkpR42zRS/soAFTI2bnIxQV7t0I+xYpXwXsgUaZ3Ng1nHKcl2AMTT05pEzRFf46hg4KYmoGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+vC9QNM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 632F3C2BD10;
	Mon, 17 Jun 2024 23:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718665914;
	bh=bpeQJSd0BsKdh9O1L/WBzXi7cm11ewlcZk3ruc8dtR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s+vC9QNMgzZdAx9M19zFTyp6wVD9TNrSnmUUiy4HB5kw9cMU8Dfh3L/a/eNyu9GOf
	 hK7ke+48a6jrsvGi0girlUcCeo11/jxkdhaJsp94/A/FLvNgdYzMW82gC8amLpE/Du
	 +FrbWG8mEmEAo9TPosKX/KEEgHuWag18qr1FVT70pNCK5DEjUCnTcRw+t1DijrhvSa
	 5CmyaUcUcQWTpD4e9wNL20UlTRm1gcMBRPhpe+v0w3+SSKfs4f4dMQDLpU2fEQi1EX
	 oCkLacYhkdAlidIlMbKYJy4HJM1yuXfh8JsjoQ/hMJSJStHazXeBu0PW1fSM9ZeZ/q
	 +Sagxf85R8Htw==
From: SeongJae Park <sj@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: SeongJae Park <sj@kernel.org>,
	yskelg@gmail.com,
	Jinwoo Park <pmnxis@gmail.com>,
	Austin Kim <austindh.kim@gmail.com>,
	shjy180909@gmail.com,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] Documentation: cve Korean translation
Date: Mon, 17 Jun 2024 16:11:48 -0700
Message-Id: <20240617231148.64366-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <87h6drgq7m.fsf@trenco.lwn.net>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi John,

On Mon, 17 Jun 2024 16:27:25 -0600 Jonathan Corbet <corbet@lwn.net> wrote:

> yskelg@gmail.com writes:
> 
> > From: Yunseong Kim <yskelg@gmail.com>
> >
> > This is a Documentation/process/cve korean version.
> >
> > The following changes have been updated based on SeongJae Park’s feedback
> > from the last v4 patch.
> >
> > Signed-off-by: Yunseong Kim <yskelg@gmail.com>
> > ---
> >  Documentation/translations/ko_KR/index.rst    |   1 +
> >  .../translations/ko_KR/process/cve.rst        | 107 ++++++++++++++++++
> >  2 files changed, 108 insertions(+)
> >  create mode 100644 Documentation/translations/ko_KR/process/cve.rst
> 
> SeongJae, are you happy with this version?

I have a trivial concern about this patch.  I'm not very confident about it,
though.  I therefore personally shared the concern with Yunseong.  Yunseong
thankfully agreed at some of my points, and he told me that he will post a new
version of this patch.

Please correct me if anything is wrong or missed, Yunseong.

So, I hope this patch to eventually be merged, but I have no strong opinion to
provide either 'Reviewed-by:' or 'Nacked-by:'.

[...]


Thanks,
SJ

