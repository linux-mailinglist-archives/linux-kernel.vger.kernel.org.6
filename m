Return-Path: <linux-kernel+bounces-392359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BCB9B9308
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 15:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98566B220A4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 14:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4B21A7273;
	Fri,  1 Nov 2024 14:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="KTHxS/jn"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DE961FDF
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 14:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730470954; cv=none; b=irkA5I2PQdB+MO9XfnRUndz353qmvSBnLrXPM372i2I1mCYXQB84GOCIc+qtBOI2RokRTG+WCQdQM62mXRiL1C3WLfEGPaVVS+yDaxnqL3GuZMhDYGXwyDK4Rh/R7+YD2PFAazQnj9rhLBrcYOc7PyGN+t2/4rlRYVCYh4Zhgp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730470954; c=relaxed/simple;
	bh=rUfk1rZcpQgVell4wpon2/ryOhCpbmTLMtB8LqbQFJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rcSwpK158kSj25txB5RiA74xR1z9uQDQowUWEZgPTqrOteFK87Fngb7xSSrntkkoB3iPv6JdVFPsFHz3nhouIdCuMhZDklfSzMFc/GQ8HYkTNRKE2FJ62ogddqsNozCEzcMxbDbsNux2/jyIe52GY8v+DwMCkN0uifr1SraUkxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=KTHxS/jn; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1730470944;
	bh=rUfk1rZcpQgVell4wpon2/ryOhCpbmTLMtB8LqbQFJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KTHxS/jnjO2+YkbE+7Hl0lcGjgDrJHZGd0Iz0QF/dUcAPBQAQoSm6ZQ4aMNWjmu9p
	 d5LxFCfDTE7Iaswv5bth3nfZNBIEoqUzX63WGDNI5YQ6eu/nimP6Nc/bwcUag+3gRp
	 Eq8B0Jb4lpiAMg0Gla0f/uRVyWjz4bz74uB94sKo=
Date: Fri, 1 Nov 2024 14:22:13 +0000
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Willy Tarreau <w@1wt.eu>, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] nolibc changes for v6.13
Message-ID: <7bac1319-fe1c-454d-b96d-8344bdce3961@t-8ch.de>
References: <ba23217d-5eaf-4146-8ed7-27289cece364@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba23217d-5eaf-4146-8ed7-27289cece364@t-8ch.de>

(resend to add missing Cc: LKML)


Hi Paul,

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git tags/nolibc-20241101-for-6.13-1

for you to fetch changes up to ad0558f3883130954ca724697f2d19aef93967b3:

  selftests/nolibc: start qemu with 1 GiB of memory (2024-10-07 21:57:45 +0200)

----------------------------------------------------------------
nolibc changes for 6.13

Changes
-------

* Fix potential error due to missing #include on s390
* Compatibility with -Wmissing-fallthrough
* Run qemu with more memory during tests

----------------------------------------------------------------
Thomas Weißschuh (3):
      tools/nolibc: s390: include std.h
      tools/nolibc: compiler: add macro __nolibc_fallthrough
      selftests/nolibc: start qemu with 1 GiB of memory

 tools/include/nolibc/arch-s390.h        | 1 +
 tools/include/nolibc/compiler.h         | 6 ++++++
 tools/include/nolibc/stdio.h            | 3 ++-
 tools/testing/selftests/nolibc/Makefile | 4 ++--
 4 files changed, 11 insertions(+), 3 deletions(-)

Test report:

$ ./run-tests.sh
i386:          195 test(s): 195 passed,   0 skipped,   0 failed => status: success
x86_64:        195 test(s): 195 passed,   0 skipped,   0 failed => status: success
arm64:         195 test(s): 195 passed,   0 skipped,   0 failed => status: success
arm:           195 test(s): 195 passed,   0 skipped,   0 failed => status: success
mips32le:      195 test(s): 194 passed,   1 skipped,   0 failed => status: warning
mips32be:      195 test(s): 194 passed,   1 skipped,   0 failed => status: warning
ppc:           195 test(s): 195 passed,   0 skipped,   0 failed => status: success
ppc64:         195 test(s): 195 passed,   0 skipped,   0 failed => status: success
ppc64le:       195 test(s): 195 passed,   0 skipped,   0 failed => status: success
riscv:         195 test(s): 195 passed,   0 skipped,   0 failed => status: success
s390:          195 test(s): 194 passed,   1 skipped,   0 failed => status: warning
loongarch:     195 test(s): 194 passed,   1 skipped,   0 failed => status: warning

$ ./run-tests.sh -m user
i386:          195 test(s): 193 passed,   2 skipped,   0 failed => status: warning
x86_64:        195 test(s): 193 passed,   2 skipped,   0 failed => status: warning
arm64:         195 test(s): 193 passed,   2 skipped,   0 failed => status: warning
arm:           195 test(s): 193 passed,   2 skipped,   0 failed => status: warning
mips32le:      195 test(s): 192 passed,   3 skipped,   0 failed => status: warning
mips32be:      195 test(s): 192 passed,   3 skipped,   0 failed => status: warning
ppc:           195 test(s): 193 passed,   2 skipped,   0 failed => status: warning
ppc64:         195 test(s): 193 passed,   2 skipped,   0 failed => status: warning
ppc64le:       195 test(s): 193 passed,   2 skipped,   0 failed => status: warning
riscv:         195 test(s): 193 passed,   2 skipped,   0 failed => status: warning
s390:          195 test(s): 192 passed,   3 skipped,   0 failed => status: warning
loongarch:     195 test(s): 192 passed,   3 skipped,   0 failed => status: warning

$ ./run-tests.sh -m user -l
i386:          195 test(s): 193 passed,   2 skipped,   0 failed => status: warning
x86_64:        195 test(s): 193 passed,   2 skipped,   0 failed => status: warning
arm64:         195 test(s): 193 passed,   2 skipped,   0 failed => status: warning
arm:           195 test(s): 193 passed,   2 skipped,   0 failed => status: warning
mips32le:      195 test(s): 192 passed,   3 skipped,   0 failed => status: warning
mips32be:      195 test(s): 192 passed,   3 skipped,   0 failed => status: warning
ppc:           195 test(s): 192 passed,   3 skipped,   0 failed => status: warning
ppc64:         195 test(s): 192 passed,   3 skipped,   0 failed => status: warning
ppc64le:       195 test(s): 192 passed,   3 skipped,   0 failed => status: warning
riscv:         195 test(s): 192 passed,   3 skipped,   0 failed => status: warning
s390:          195 test(s): 192 passed,   3 skipped,   0 failed => status: warning
loongarch:     195 test(s): 192 passed,   3 skipped,   0 failed => status: warning


Thanks,
Thomas

