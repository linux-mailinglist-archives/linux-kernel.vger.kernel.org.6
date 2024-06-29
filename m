Return-Path: <linux-kernel+bounces-234901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C89391CC36
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 13:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10F222834E8
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 11:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A00A44C93;
	Sat, 29 Jun 2024 11:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="XaVivSEy"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F27639FD9
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 11:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719659055; cv=none; b=HHhxLuJF10JHJy71Z6ruZEmhpSoaTcAne8l+as/+uuRpzb/VsgviVHE8kDtQlnKgN/SdC9I50Cu3JciiCKOOBhwRvv08cyahs3M0J+Cbh9iUGLekEnZCkLUQDO8v/VpLmg8RG0/3l0T58pF3DmhLLwobrNgiua49c7RI2FZVrLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719659055; c=relaxed/simple;
	bh=JhO+2b+DwVAokiAMBjkHZzrzpA6hJjbuEwKjrb7dSMM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=u+YYAEra2+2kc3z4QrhGe6Q9DP/5TdK4gYk3Wkp1WSDwrby5TYjJ7Pn1/Lgr3NCw3w9bV0uYOzco8ATOUbtT0jbpzz05i/2gwlQJqeY0qNBma3IcAZJvPJAH6k4kdRK4AB+6bP/9tVkqZLM8Vpp+a5Qp8zzS67jwejlDj5DSXDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=XaVivSEy; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1719659049;
	bh=JhO+2b+DwVAokiAMBjkHZzrzpA6hJjbuEwKjrb7dSMM=;
	h=Date:From:To:Cc:Subject:From;
	b=XaVivSEyuZu8Z/aoYtJhQlSUHoZXSRnXd//Gqcsy/MK/j/2H6M+QlvDSrn9hqMP1A
	 tUHcoMZKEpKJjFbLPz+p9dTWYl6XgG/wK3s468/iGYpZbCaWGNwoGZjGhsV2ujSz1W
	 pJyjZRjrCaUPL5gevFilrAL349AftgEYZfCRmXM8=
Date: Sat, 29 Jun 2024 13:04:08 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Willy Tarreau <w@1wt.eu>, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] nolibc for 6.11-rc1
Message-ID: <acffd5b1-36a8-4336-9b94-aec50b3d6e5b@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Paul,

The following changes since commit f2661062f16b2de5d7b6a5c42a9a5c96326b8454:

  Linux 6.10-rc5 (2024-06-23 17:08:54 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git tags/nolibc-20240629-for-6.11-1

for you to fetch changes up to 6ca8f2e20bd1ced8a7cd12b3ae4b1ceca85cfc2b:

  selftests: kselftest: also use strerror() on nolibc (2024-06-29 09:44:58 +0200)

----------------------------------------------------------------
Thomas Weißschuh (8):
      selftests/nolibc: fix printf format mismatch in expect_str_buf_eq()
      selftests/nolibc: disable brk()/sbrk() tests on musl
      selftests/nolibc: run-tests.sh: use -Werror by default
      tools/nolibc: add limits for {u,}intmax_t, ulong and {u,}llong
      tools/nolibc: implement strtol() and friends
      selftests/nolibc: introduce condition to run tests only on nolibc
      tools/nolibc: implement strerror()
      selftests: kselftest: also use strerror() on nolibc

 tools/include/nolibc/stdint.h                |  19 +++++
 tools/include/nolibc/stdio.h                 |  10 +++
 tools/include/nolibc/stdlib.h                | 109 +++++++++++++++++++++++++++
 tools/testing/selftests/kselftest.h          |   8 --
 tools/testing/selftests/nolibc/Makefile      |   2 +-
 tools/testing/selftests/nolibc/nolibc-test.c | 109 ++++++++++++++++++++++-----
 tools/testing/selftests/nolibc/run-tests.sh  |   9 ++-
 7 files changed, 238 insertions(+), 28 deletions(-)


Thanks,
Thomas

