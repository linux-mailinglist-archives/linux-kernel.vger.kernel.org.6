Return-Path: <linux-kernel+bounces-343912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D4498A12D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98E25B276DC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7881418DF86;
	Mon, 30 Sep 2024 11:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zFHgkkMO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MuSKSdL3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zFHgkkMO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MuSKSdL3"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7625118990E
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 11:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727697157; cv=none; b=BXUN57pGR1xNfbB1De09V7bKF+PJgNP1GCCaAm4HPiuNYulTxTMOhfuXDAJfdxkkFTRVl/H5JnGTkQErER7C8JgYtJgJByMkB3cNNjCXpniFw8YtaHb9oqqsBJDHGRa/su2FXkVvqXU83oH/qywYNwyXsBJPs7rrhAFf8eNHRtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727697157; c=relaxed/simple;
	bh=BQ3ammF6+633BA/ACXw5T4DVVVop4JiH1dRjxP1N6Vw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RQJ3CWwQsBnZyGf5MXqrLmnpqbdu45QV8sWanRWBMmPzqO4/bCB2fXo+TxIVvTjk1koKDtG3NTaN8z1q7uH70aJTWURBrUg8WR5yTDZMRJPXVgrxlC/NuKIXYgPPihJHqRIbHCDR3GI0AWEQmsdizoh+7VStJMs7hEKEbGGXWC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zFHgkkMO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MuSKSdL3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zFHgkkMO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MuSKSdL3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7DC1A21A3C;
	Mon, 30 Sep 2024 11:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727697153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=/pnUAT53WPuScqS8657hEzD2/NsbLFYs+1LRgOYBBt0=;
	b=zFHgkkMOImtP8l/21m9DAB8/l4GSPmhKWShwEgOZDLDMyrxVtZkbTDfLH4IF6Sh8TnMIkJ
	ugmhzDyK1w1lwlfq4R6j+MBHW9tqKAdxpnjphEQOIa8OXOgzJkyhUczUT7sB/IMyoc9Zkn
	pgbTJlD75BB+dC+thJFdf/R03+Du4ag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727697153;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=/pnUAT53WPuScqS8657hEzD2/NsbLFYs+1LRgOYBBt0=;
	b=MuSKSdL3tZaWWb3Lb8q7aFppyOl2H5PJk08iywjeCx8KsMTvJx32nVKX68GNiGP61Hzo/I
	8qqbOUjJTIOz+IAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zFHgkkMO;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=MuSKSdL3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727697153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=/pnUAT53WPuScqS8657hEzD2/NsbLFYs+1LRgOYBBt0=;
	b=zFHgkkMOImtP8l/21m9DAB8/l4GSPmhKWShwEgOZDLDMyrxVtZkbTDfLH4IF6Sh8TnMIkJ
	ugmhzDyK1w1lwlfq4R6j+MBHW9tqKAdxpnjphEQOIa8OXOgzJkyhUczUT7sB/IMyoc9Zkn
	pgbTJlD75BB+dC+thJFdf/R03+Du4ag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727697153;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=/pnUAT53WPuScqS8657hEzD2/NsbLFYs+1LRgOYBBt0=;
	b=MuSKSdL3tZaWWb3Lb8q7aFppyOl2H5PJk08iywjeCx8KsMTvJx32nVKX68GNiGP61Hzo/I
	8qqbOUjJTIOz+IAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6729613A8B;
	Mon, 30 Sep 2024 11:52:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4rNuGAGR+mb+WwAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Mon, 30 Sep 2024 11:52:33 +0000
Date: Mon, 30 Sep 2024 13:51:32 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it, linux-kernel@vger.kernel.org,
	libc-alpha@sourceware.org
Cc: lwn@lwn.net, akpm@linux-foundation.org, torvalds@linux-foundation.org
Subject: [ANNOUNCE] The Linux Test Project has been released for SEPTEMBER
 2024
Message-ID: <ZvqQxP9KVW6PqFOo@yuki.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: 7DC1A21A3C
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

Good news everyone,

the Linux Test Project test suite stable release for *September 2024* has been
released.

Since the last release 266 patches by 47 authors were merged.

Patch review is what most of the projects struggle with and LTP is no
different. If you can spare some effort helping with the patch review is more
than welcomed.

NOTABLE CHANGES
===============

* New tests

  - chown09 regression test for 5d1f903f75a8 ("attr: block mode changes of symlinks")
  - request_key06 Negative tests for request_key() syscall
  - signalfd02 Negative tests for signalfd() syscall
  - mseal02 Negative tests for mseal() syscall
  - hugeshmget06 A hugepage shm test
  - landlock07 Landlock Houdini reproducer aka CVE-2024-42318
  - getcpu02 Negative tests for getcpu() syscall
  - landlock06 Tests for LANDLOCK_ACCESS_FS_IOCTL_DEV
  - landlock05 Tests for LONDLOCK_ACCESS_FS_REFER
  - landlock04 Tests that syscalls are enabled/disable accordingly to the ruleset
  - landlock03 Negative tests for landlock_restrict_self() syscall
  - landlock02 Negative tests for landlock_add_rule() syscall
  - landlock01 Negative tests for landlock_create_ruleset() syscall
  - mseal01 Tests that memory is protected from being changed after it's sealed
  - fchmodat2_02 Negative tests for fchmodat2()
  - fchmodat2_01 Tests for AT_SYMLINK_NOFOLLOW for fchmodat2()
  - cachestat04 Checks that cachestat() syscall either reports EBADF or zeroed
    statistics on all kinds of unsupported fds
  - cachestat03 Negative tests for cachestat() syscall
  - cachestat02 Basic cachestat tests with fd pointing to shared memory
  - cachestat01 Basic cachestat tests for regular files
  - shutdown01 Basic shutdown tests
  - shutdown02 Negative tests for shutdown() sycall

* The symlink01 mess is being split into separate testcases

  - open15 A test that open() syscall works correctly with symlinks
  - lstat03 A basic lstat() test.
  - rename15 Tests that rename works correctly with symlinks
  - chmod08 Tests that chmod() works correctly with symlinks

* Increased coverage

  - readdir and getdents tests were enabled to run on all supported filesystems
    after we found that bcachefs had sublty broken implementation
  - gedent02 Adds more negative tests
  - timer_settime01 Now checks for premature timer expiration as well
  - pkey01 Now includes tests for PKEY_DISABLE_EXECUTE
  - request_key01 Added more negative tests
  - acct02 Added more negative tests
  - prctl04 has been renamed to seccomp01 and now covers also the seccomp()
    syscall along with the older prctl(PR_SET_SECCOMP) calls
  - msync04 now uses direct I/O to verify that data have been written to disk

* Rewritten tests

  - fork05 was rewritten and correctly reports TCONF on non i386 hardware
  - fcnt14 a file locking test was rewriten to generate subtests at runtime
  - sched_starvation now autocallibrates expected runtime based on CPU speed
  - sched_footbal was rewritten and is now executed as part of the sched
    runtest file

* The test library now supports specifying mkfs and mount options per a
  filesystem

* Bunch of checks for kernels older than 4.4 were removed from the tests since
  the currently minimal kernel version LTP supports is 4.4

* We have a new shell test library that:
  - makes shell code seamlessly interoperable with C
  - reuses most of the C test library
  - makes use shared memory to report test results
  - there are currently no tests using this library, we will start rewriting
    existing tests after the release

* 3 testcases were converted to the new test library

+ The usual amount of fixes and cleanups

REMOVED SCRIPTS AND FILES
=========================

- Removed old and outdated man pages.

- Removed ltpmenu an legacy script that was unmaintained for a decade.

NOTABLE CHANGES IN NETWORK TESTS
================================
brought to you by Petr Vorel

- nfsstat02.sh new test for per-NS NFS client statistics
               (checks that /proc/net/rpc/nfs exists in nested network namespaces)

- nfsstat01.sh read client stats from netns rhost
               (fix for kernel 6.9, backported up to 5.10 so far)

- nfs02.sh Added subtest for O_DIRECT

KIRK
====

- Kirk has been update to 1.4
- Kirk can now be installed from pypi

DOWNLOAD AND LINKS
==================

The latest version of the test-suite contains 3000+ tests for the Linux
and can be downloaded at:

https://github.com/linux-test-project/ltp/releases/tag/20240930

The project pages as well as GIT repository are hosted on GitHub:

https://github.com/linux-test-project/ltp

If you ever wondered how to write a LTP testcase, don't miss our developer
documentation at:

https://linux-test-project.readthedocs.io/en/latest/developers/test_case_tutorial.html

And our library API documentation at:

https://linux-test-project.readthedocs.io/en/latest/developers/api_c_tests.html

Patches, new tests, bugs, comments or questions should go to to our mailing
list at ltp@lists.linux.it.

CREDITS
=======

Many thanks to the people contributing to this release:

git shortlog -s -e -n 20240129..

   233	Petr Vorel <pvorel@suse.cz>
    74	Andrea Cervesato <andrea.cervesato@suse.com>
    39	Martin Doucha <mdoucha@suse.cz>
    36	Li Wang <liwang@redhat.com>
    25	Cyril Hrubis <chrubis@suse.cz>
    25	Yang Xu <xuyang2018.jy@fujitsu.com>
    22	Xinjian Ma (Fujitsu) <maxj.fnst@fujitsu.com>
    21	Wei Gao <wegao@suse.com>
    15	Andrea Manzini <andrea.manzini@suse.com>
     6	Avinesh Kumar <akumar@suse.de>
     6	Edward Liaw <edliaw@google.com>
     6	John Stultz <jstultz@google.com>
     4	Hui Min Mina Chou <minachou@andestech.com>
     4	Jan Stancek <jstancek@redhat.com>
     3	Andreas Schwab <schwab@suse.de>
     3	Xiao Yang <ice_yangxiao@163.com>
     3	lufei <lufei@uniontech.com>
     2	Dennis Brendel <dbrendel@redhat.com>
     2	Jiwei Sun <sunjw10@lenovo.com>
     2	Po-Hsu Lin <po-hsu.lin@canonical.com>
     1	Ajay Kaher <ajay.kaher@broadcom.com>
     1	Amir Goldstein <amir73il@gmail.com>
     1	Chen Haonan <chen.haonan2@zte.com.cn>
     1	Chuck Lever <chuck.lever@oracle.com>
     1	Detlef Riekenberg via ltp <ltp@lists.linux.it>
     1	Filippo Storniolo <fstornio@redhat.com>
     1	Haifeng Xu <haifeng.xu@shopee.com>
     1	Jingyi Song <jingyisong@hust.edu.cn>
     1	Khem Raj <raj.khem@gmail.com>
     1	Kuan-Ying Lee <kuan-ying.lee@canonical.com>
     1	Li Xiaosong <rj45usb@163.com>
     1	Madadi Vineeth Reddy <vineethr@linux.ibm.com>
     1	Mete Durlu <meted@linux.ibm.com>
     1	Murphy Zhou <jencce.kernel@gmail.com>
     1	Nirjhar Roy <nirjhar@linux.ibm.com>
     1	Remi Peuvergne <remi.peuvergne@kaizen-solutions.net>
     1	Sachin P Bappalige <sachinpb@linux.ibm.com>
     1	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
     1	Sebastian Chlad <sebastianchlad@gmail.com>
     1	Sergey Ulanov via ltp <ltp@lists.linux.it>
     1	Shiyang Ruan <ruansy.fnst@fujitsu.com>
     1	Shizhao Chen <shichen@redhat.com>
     1	Wenjie Xu <xuwenjie04@baidu.com>
     1	Xiangyu Chen <xiangyu.chen@windriver.com>
     1	Yiwei Lin <s921975628@gmail.com>
     1	Zizhi Wo <wozizhi@huawei.com>
     1	yangfeng <yangfeng@kylinos.cn>

And also thanks to patch reviewers:

git log 20240129.. | grep -Ei '(reviewed|acked)-by:' | sed 's/.*by: //' | sort | uniq -c | sort -n -r

    212 Petr Vorel <pvorel@suse.cz>
    181 Cyril Hrubis <chrubis@suse.cz>
    108 Li Wang <liwang@redhat.com>
     39 Avinesh Kumar <akumar@suse.de>
     28 Andrea Cervesato <andrea.cervesato@suse.com>
     16 Martin Doucha <mdoucha@suse.cz>
     10 Jan Stancek <jstancek@redhat.com>
      6 Jan Kara <jack@suse.cz>
      4 Wei Gao <wegao@suse.com>
      4 Richard Palethorpe <io@richiejp.com>
      3 Marius Kittler <mkittler@suse.de>
      3 Amir Goldstein <amir73il@gmail.com>
      2 Adrian Huang <ahuang12@lenovo.com>
      1 Vlastimil Babka <vbabka@suse.cz>
      1 Po-Hsu Lin <po-hsu.lin@canonical.com>
      1 Matt Bobrowski <mattbobrowski@google.com>
      1 Kent Overstreet <kent.overstreet@linux.dev>
      1 Joerg Vehlow <joerg.vehlow@aox.de>

-- 
Cyril Hrubis
chrubis@suse.cz

