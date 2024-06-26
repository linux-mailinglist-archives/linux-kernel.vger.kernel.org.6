Return-Path: <linux-kernel+bounces-231612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB9D919AD3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 00:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C65B31F21F56
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7B6194081;
	Wed, 26 Jun 2024 22:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aoJ9CWRn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B7D15D5C1;
	Wed, 26 Jun 2024 22:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719442131; cv=none; b=aJ3YkiopymuWW4sDHvdajGplRR3AwwQHR/7uGup82OPZ+GojRodemwcOfpWTPZsQ05NRZrEHEWH34yEqnbfA6h46m/qa9U+jQaBs80Z3ZnWEdtycWeLvODhW7H7FwzQ3nC6pCCxdzKrWbIAfAgYbAuxFAldZCQo5KuPqpU8ucu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719442131; c=relaxed/simple;
	bh=Y3x/7Ek//hFsCeCb/ZW/lS86n7PzhLJb9wiw4wJsyWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bNOpDTU+g+k1kd2cTFB42yyj0/0uXn/S2yidxzG1U0BHbx/3yRR5PEN6M0sWDGShNMkj8bTR6oRzj4xOBRrHX0SKNV1GrfnGAVTz5KNsXuQatXqXJUnEn4S3bUs5vpyAZ85+C6TQD9r92GWWf5YhsJrA0ZtKT+haxjO3b/JpvsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aoJ9CWRn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E3FC116B1;
	Wed, 26 Jun 2024 22:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719442131;
	bh=Y3x/7Ek//hFsCeCb/ZW/lS86n7PzhLJb9wiw4wJsyWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aoJ9CWRnrATvKGqW9bvjoOnuA8Wqu5/5KGfq6wPOconHSXbLOc0pnnrw0KCJ71iR7
	 FPMWH94ohp82J5pWH/Xbe9Qw+uUdml7FN5WPlo3IdC7PVfhp/9aT5UIsj8TwA+IbXz
	 UdqGQivM4f9XenWeoitqLCSftc9UczJYHGyVxcpVBrvtmIp9aiLo6DbtDsIxSS1fTl
	 rMewpsjO+WvAbl+QBMdpG95ese90EzWXmr+b5merwzZg0V8GPk8uPzRU/LRUeJFk1K
	 OktTt2sitxjVL0ET7XzQk0Tqgt4TDxD9FLuTZne82JTEEM/NAxeRPaEwdad2IRKcfQ
	 9XQxXRZWHcHyQ==
From: SeongJae Park <sj@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: SeongJae Park <sj@kernel.org>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] Docs/process/email-clients: Document HacKerMaiL
Date: Wed, 26 Jun 2024 15:48:46 -0700
Message-Id: <20240626224846.67416-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <874j9fz60q.fsf@trenco.lwn.net>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 26 Jun 2024 16:35:49 -0600 Jonathan Corbet <corbet@lwn.net> wrote:

> SeongJae Park <sj@kernel.org> writes:
> 
> > HacKerMaiL (hkml) [1] is a simple tool for mailing lists-based
> > development workflows such as that for most Linux kernel subsystems.  It
> > is actively being maintained by DAMON maintainer, and recommended for
> > DAMON community[2].  Add a simple introduction of the tool on the
> > email-clients document, too.
> >
> > [1] https://github.com/sjp38/hackermail
> > [2] https://lore.kernel.org/20240621170353.BFB83C2BBFC@smtp.kernel.org
> >
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> >  Documentation/process/email-clients.rst | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> 
> We should really document lei as well

I'd also love that.  But I cannot document lei here on my own since I don't
know how to use it :'(

I might try again, but please don't wait for me.

> if we're going to do this, but I won't try to insist on that here...:)

Thank you for understanding, Jon! :)


Thanks,
SJ

[...]

