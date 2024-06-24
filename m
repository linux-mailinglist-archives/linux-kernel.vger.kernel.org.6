Return-Path: <linux-kernel+bounces-227805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B589156B9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20CB81C21742
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DB71A0AEA;
	Mon, 24 Jun 2024 18:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7Ly9Odh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CEB1A01B6;
	Mon, 24 Jun 2024 18:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719255205; cv=none; b=gwaAdOruDXFIEwtRbzIS38MqmqfwikEuJLss8UX0f40HHLkBja3jFYaWbRQc7tVWju1kaB1/a4X63XgpdlMbFd/k3qQ9OyWlI1mWfY75TafIEE4wKUITgO4vPpT4Uto0tfV5TrAV2HUUStoJx2H9zW1uR1vI8X/ScA2fq+DKYbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719255205; c=relaxed/simple;
	bh=jJ/j1xsThnzacKt11bhaVunfEXAeA8U4Nty6fqr9cTg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cL9G+WN6uP+i5VzNfIdY48rx3FcRAfIPPgKMJssZF8gJaNXvEBk75DPnoMqHuuD+H7leWqcojTugwrjcjhFsIBLhxi/p0bNvlOxg43jdvv31OF7i+TJq/6UD8GzYyiy/IhKJfuBBeCsQ56jklNb6x9xCajV3kAfEWnnuXbH0iTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7Ly9Odh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3742C32782;
	Mon, 24 Jun 2024 18:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719255205;
	bh=jJ/j1xsThnzacKt11bhaVunfEXAeA8U4Nty6fqr9cTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C7Ly9OdhU/Y+BH6NcUw9QGJQWNG/AF3NuCaeAmjpNT7J2TOT/oCqsbacAO69HExfK
	 meZyCv8GPvZndonbKlxaNctVzcfvfv/QkYiPCA3S5M650qJTuDIv8xmzI3t2bVe1HK
	 M1rPS9Ve1JiM/NtpyXl6dlcEet4jdD+umeIDg4wg/5gDNXQ3ZbHxmclVgKgv3c8zJ2
	 pFYG9HWciU5twEvSzvBE1fuOuSkLzz+jVx9bln9kpC5JeGTTNxPxPUTYHbZhHZuemf
	 pni8wQlP7c0dIUtA6kxAyugJ7X8dvAmaciXX1TDDCijmAKHAI/A8r4JVWeSMBDqPFh
	 jOZWen0I+xBLQ==
From: SeongJae Park <sj@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: SeongJae Park <sj@kernel.org>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] Docs/process/email-clients: Document HacKerMaiL
Date: Mon, 24 Jun 2024 11:53:12 -0700
Message-Id: <20240624185312.94537-8-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240624185312.94537-1-sj@kernel.org>
References: <20240624185312.94537-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HacKerMaiL (hkml) [1] is a simple tool for mailing lists-based
development workflows such as that for most Linux kernel subsystems.  It
is actively being maintained by DAMON maintainer, and recommended for
DAMON community[2].  Add a simple introduction of the tool on the
email-clients document, too.

[1] https://github.com/sjp38/hackermail
[2] https://lore.kernel.org/20240621170353.BFB83C2BBFC@smtp.kernel.org

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/process/email-clients.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/process/email-clients.rst b/Documentation/process/email-clients.rst
index fc2c46f3f82d..dd22c46d1d02 100644
--- a/Documentation/process/email-clients.rst
+++ b/Documentation/process/email-clients.rst
@@ -350,3 +350,12 @@ although tab2space problem can be solved with external editor.
 
 Another problem is that Gmail will base64-encode any message that has a
 non-ASCII character. That includes things like European names.
+
+HacKerMaiL (TUI)
+****************
+
+HacKerMaiL (hkml) is a public-inbox based simple mails management tool that
+doesn't require subscription of mailing lists.  It is developed and maintained
+by the DAMON maintainer and aims to support simple development workflows for
+DAMON and general kernel subsystems.  Refer to the README
+(https://github.com/sjp38/hackermail/blob/master/README.md) for details.
-- 
2.39.2


