Return-Path: <linux-kernel+bounces-366370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 808DA99F477
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9043B2308B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604191FC7D7;
	Tue, 15 Oct 2024 17:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/NCcirn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBC91FAF14;
	Tue, 15 Oct 2024 17:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729014863; cv=none; b=OmJ1vFcXCcRvOwjGiklfNjf5r8q199e3BVReGhp8EccMZ2jHP9eLwQK7Ee7X468Y376e9VFsvl+PfwVLMhqztsglm/6lRAei4SQYzD6JuYdQWvT4nXiTiPZvCjUTnGixm8YnoPwk+bDLWaLSSuWV1ufZ69H2QBaWteVtlZPUf1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729014863; c=relaxed/simple;
	bh=CKcT9mDCKGTEuzVadIyy50mQuu1BV9tFkUqyOuuB6ho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qW8er2ogXYKS7MfMimizWjNif59cJWP3vmnn/1qiz0MdU72nmpkuh9g02K/zddcssNC6vbMP5WUE3Zm7oFsVFpnoIf+IBilsHRtRDag8wbMwMYwapWuzJy8VkAc47Ccy9rFB+nC9MShun2V2vIEvzs+Q+VSTFI/z32XnJnLpRTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/NCcirn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B779C4CECF;
	Tue, 15 Oct 2024 17:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729014862;
	bh=CKcT9mDCKGTEuzVadIyy50mQuu1BV9tFkUqyOuuB6ho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s/NCcirnrthjZBo65NC5ZyIo/PFULHy3AJApJ4fo0pvU+IOnNpbXBmPhcapWmn/ez
	 0fM77vlnUh3lKyh4RuC18EQo+2P9vRNaCsen6+efJLOPb5xivmWyHyztD9yv777Nlq
	 77NTuZx4JXlpxdfoChorkxo3UH9b8g4qWcBscH4w15elfMP5JxNmmz77Ldr6tVyr/J
	 AwrbvBjKArd9ndQ1KyeYpYJkFkj8asLvwUF73RPLlVdpo9bqj0ab7WhAyIJnaJY3Za
	 cTEbrWV7C9pfTpjnQVLO3m8h9am/O+0RFIMDpylE4Dxl+z5DpUr0mrj+HBd8FdjMrO
	 K3rbCfLb9dBSw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/7] Docs/admin-guide/mm/damon/usage: remove DAMON debugfs interface documentation
Date: Tue, 15 Oct 2024 10:54:06 -0700
Message-Id: <20241015175412.60563-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241015175412.60563-1-sj@kernel.org>
References: <20241015175412.60563-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's time to remove DAMON debugfs interface, which has deprecated long
before in February 2023.  Read the cover letter of this patch series for
more details.

Remove DAMON debugfs interface usage documentation, to avoid confusing
users with documents for an already removed thing.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 309 -------------------
 1 file changed, 309 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index d9be9f7caa7d..c685d87ea078 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -26,12 +26,6 @@ DAMON provides below interfaces for different users.
   writing kernel space DAMON application programs for you.  You can even extend
   DAMON for various address spaces.  For detail, please refer to the interface
   :doc:`document </mm/damon/api>`.
-- *debugfs interface. (DEPRECATED!)*
-  :ref:`This <debugfs_interface>` is almost identical to :ref:`sysfs interface
-  <sysfs_interface>`.  This is deprecated, so users should move to the
-  :ref:`sysfs interface <sysfs_interface>`.  If you depend on this and cannot
-  move, please report your usecase to damon@lists.linux.dev and
-  linux-mm@kvack.org.
 
 .. _sysfs_interface:
 
@@ -600,306 +594,3 @@ fields are as usual.  It shows the index of the DAMON context (``ctx_idx=X``)
 of the scheme in the list of the contexts of the context's kdamond, the index
 of the scheme (``scheme_idx=X``) in the list of the schemes of the context, in
 addition to the output of ``damon_aggregated`` tracepoint.
-
-
-.. _debugfs_interface:
-
-debugfs Interface (DEPRECATED!)
-===============================
-
-.. note::
-
-  THIS IS DEPRECATED!
-
-  DAMON debugfs interface is deprecated, so users should move to the
-  :ref:`sysfs interface <sysfs_interface>`.  If you depend on this and cannot
-  move, please report your usecase to damon@lists.linux.dev and
-  linux-mm@kvack.org.
-
-DAMON exports nine files, ``DEPRECATED``, ``attrs``, ``target_ids``,
-``init_regions``, ``schemes``, ``monitor_on_DEPRECATED``, ``kdamond_pid``,
-``mk_contexts`` and ``rm_contexts`` under its debugfs directory,
-``<debugfs>/damon/``.
-
-
-``DEPRECATED`` is a read-only file for the DAMON debugfs interface deprecation
-notice.  Reading it returns the deprecation notice, as below::
-
-    # cat DEPRECATED
-    DAMON debugfs interface is deprecated, so users should move to DAMON_SYSFS. If you cannot, please report your usecase to damon@lists.linux.dev and linux-mm@kvack.org.
-
-
-Attributes
-----------
-
-Users can get and set the ``sampling interval``, ``aggregation interval``,
-``update interval``, and min/max number of monitoring target regions by
-reading from and writing to the ``attrs`` file.  To know about the monitoring
-attributes in detail, please refer to the :doc:`/mm/damon/design`.  For
-example, below commands set those values to 5 ms, 100 ms, 1,000 ms, 10 and
-1000, and then check it again::
-
-    # cd <debugfs>/damon
-    # echo 5000 100000 1000000 10 1000 > attrs
-    # cat attrs
-    5000 100000 1000000 10 1000
-
-
-Target IDs
-----------
-
-Some types of address spaces supports multiple monitoring target.  For example,
-the virtual memory address spaces monitoring can have multiple processes as the
-monitoring targets.  Users can set the targets by writing relevant id values of
-the targets to, and get the ids of the current targets by reading from the
-``target_ids`` file.  In case of the virtual address spaces monitoring, the
-values should be pids of the monitoring target processes.  For example, below
-commands set processes having pids 42 and 4242 as the monitoring targets and
-check it again::
-
-    # cd <debugfs>/damon
-    # echo 42 4242 > target_ids
-    # cat target_ids
-    42 4242
-
-Users can also monitor the physical memory address space of the system by
-writing a special keyword, "``paddr\n``" to the file.  Because physical address
-space monitoring doesn't support multiple targets, reading the file will show a
-fake value, ``42``, as below::
-
-    # cd <debugfs>/damon
-    # echo paddr > target_ids
-    # cat target_ids
-    42
-
-Note that setting the target ids doesn't start the monitoring.
-
-
-Initial Monitoring Target Regions
----------------------------------
-
-In case of the virtual address space monitoring, DAMON automatically sets and
-updates the monitoring target regions so that entire memory mappings of target
-processes can be covered.  However, users can want to limit the monitoring
-region to specific address ranges, such as the heap, the stack, or specific
-file-mapped area.  Or, some users can know the initial access pattern of their
-workloads and therefore want to set optimal initial regions for the 'adaptive
-regions adjustment'.
-
-In contrast, DAMON do not automatically sets and updates the monitoring target
-regions in case of physical memory monitoring.  Therefore, users should set the
-monitoring target regions by themselves.
-
-In such cases, users can explicitly set the initial monitoring target regions
-as they want, by writing proper values to the ``init_regions`` file.  The input
-should be a sequence of three integers separated by white spaces that represent
-one region in below form.::
-
-    <target idx> <start address> <end address>
-
-The ``target idx`` should be the index of the target in ``target_ids`` file,
-starting from ``0``, and the regions should be passed in address order.  For
-example, below commands will set a couple of address ranges, ``1-100`` and
-``100-200`` as the initial monitoring target region of pid 42, which is the
-first one (index ``0``) in ``target_ids``, and another couple of address
-ranges, ``20-40`` and ``50-100`` as that of pid 4242, which is the second one
-(index ``1``) in ``target_ids``.::
-
-    # cd <debugfs>/damon
-    # cat target_ids
-    42 4242
-    # echo "0   1       100 \
-            0   100     200 \
-            1   20      40  \
-            1   50      100" > init_regions
-
-Note that this sets the initial monitoring target regions only.  In case of
-virtual memory monitoring, DAMON will automatically updates the boundary of the
-regions after one ``update interval``.  Therefore, users should set the
-``update interval`` large enough in this case, if they don't want the
-update.
-
-
-Schemes
--------
-
-Users can get and set the DAMON-based operation :ref:`schemes
-<damon_design_damos>` by reading from and writing to ``schemes`` debugfs file.
-Reading the file also shows the statistics of each scheme.  To the file, each
-of the schemes should be represented in each line in below form::
-
-    <target access pattern> <action> <quota> <watermarks>
-
-You can disable schemes by simply writing an empty string to the file.
-
-Target Access Pattern
-~~~~~~~~~~~~~~~~~~~~~
-
-The target access :ref:`pattern <damon_design_damos_access_pattern>` of the
-scheme.  The ``<target access pattern>`` is constructed with three ranges in
-below form::
-
-    min-size max-size min-acc max-acc min-age max-age
-
-Specifically, bytes for the size of regions (``min-size`` and ``max-size``),
-number of monitored accesses per aggregate interval for access frequency
-(``min-acc`` and ``max-acc``), number of aggregate intervals for the age of
-regions (``min-age`` and ``max-age``) are specified.  Note that the ranges are
-closed interval.
-
-Action
-~~~~~~
-
-The ``<action>`` is a predefined integer for memory management :ref:`actions
-<damon_design_damos_action>`.  The mapping between the ``<action>`` values and
-the memory management actions is as below.  For the detailed meaning of the
-action and DAMON operations set supporting each action, please refer to the
-list on :ref:`design doc <damon_design_damos_action>`.
-
- - 0: ``willneed``
- - 1: ``cold``
- - 2: ``pageout``
- - 3: ``hugepage``
- - 4: ``nohugepage``
- - 5: ``stat``
-
-Quota
-~~~~~
-
-Users can set the :ref:`quotas <damon_design_damos_quotas>` of the given scheme
-via the ``<quota>`` in below form::
-
-    <ms> <sz> <reset interval> <priority weights>
-
-This makes DAMON to try to use only up to ``<ms>`` milliseconds for applying
-the action to memory regions of the ``target access pattern`` within the
-``<reset interval>`` milliseconds, and to apply the action to only up to
-``<sz>`` bytes of memory regions within the ``<reset interval>``.  Setting both
-``<ms>`` and ``<sz>`` zero disables the quota limits.
-
-For the :ref:`prioritization <damon_design_damos_quotas_prioritization>`, users
-can set the weights for the three properties in ``<priority weights>`` in below
-form::
-
-    <size weight> <access frequency weight> <age weight>
-
-Watermarks
-~~~~~~~~~~
-
-Users can specify :ref:`watermarks <damon_design_damos_watermarks>` of the
-given scheme via ``<watermarks>`` in below form::
-
-    <metric> <check interval> <high mark> <middle mark> <low mark>
-
-``<metric>`` is a predefined integer for the metric to be checked.  The
-supported numbers and their meanings are as below.
-
- - 0: Ignore the watermarks
- - 1: System's free memory rate (per thousand)
-
-The value of the metric is checked every ``<check interval>`` microseconds.
-
-If the value is higher than ``<high mark>`` or lower than ``<low mark>``, the
-scheme is deactivated.  If the value is lower than ``<mid mark>``, the scheme
-is activated.
-
-.. _damos_stats:
-
-Statistics
-~~~~~~~~~~
-
-It also counts the total number and bytes of regions that each scheme is tried
-to be applied, the two numbers for the regions that each scheme is successfully
-applied, and the total number of the quota limit exceeds.  This statistics can
-be used for online analysis or tuning of the schemes.
-
-The statistics can be shown by reading the ``schemes`` file.  Reading the file
-will show each scheme you entered in each line, and the five numbers for the
-statistics will be added at the end of each line.
-
-Example
-~~~~~~~
-
-Below commands applies a scheme saying "If a memory region of size in [4KiB,
-8KiB] is showing accesses per aggregate interval in [0, 5] for aggregate
-interval in [10, 20], page out the region.  For the paging out, use only up to
-10ms per second, and also don't page out more than 1GiB per second.  Under the
-limitation, page out memory regions having longer age first.  Also, check the
-free memory rate of the system every 5 seconds, start the monitoring and paging
-out when the free memory rate becomes lower than 50%, but stop it if the free
-memory rate becomes larger than 60%, or lower than 30%".::
-
-    # cd <debugfs>/damon
-    # scheme="4096 8192  0 5    10 20    2"  # target access pattern and action
-    # scheme+=" 10 $((1024*1024*1024)) 1000" # quotas
-    # scheme+=" 0 0 100"                     # prioritization weights
-    # scheme+=" 1 5000000 600 500 300"       # watermarks
-    # echo "$scheme" > schemes
-
-
-Turning On/Off
---------------
-
-Setting the files as described above doesn't incur effect unless you explicitly
-start the monitoring.  You can start, stop, and check the current status of the
-monitoring by writing to and reading from the ``monitor_on_DEPRECATED`` file.
-Writing ``on`` to the file starts the monitoring of the targets with the
-attributes.  Writing ``off`` to the file stops those.  DAMON also stops if
-every target process is terminated.  Below example commands turn on, off, and
-check the status of DAMON::
-
-    # cd <debugfs>/damon
-    # echo on > monitor_on_DEPRECATED
-    # echo off > monitor_on_DEPRECATED
-    # cat monitor_on_DEPRECATED
-    off
-
-Please note that you cannot write to the above-mentioned debugfs files while
-the monitoring is turned on.  If you write to the files while DAMON is running,
-an error code such as ``-EBUSY`` will be returned.
-
-
-Monitoring Thread PID
----------------------
-
-DAMON does requested monitoring with a kernel thread called ``kdamond``.  You
-can get the pid of the thread by reading the ``kdamond_pid`` file.  When the
-monitoring is turned off, reading the file returns ``none``. ::
-
-    # cd <debugfs>/damon
-    # cat monitor_on_DEPRECATED
-    off
-    # cat kdamond_pid
-    none
-    # echo on > monitor_on_DEPRECATED
-    # cat kdamond_pid
-    18594
-
-
-Using Multiple Monitoring Threads
----------------------------------
-
-One ``kdamond`` thread is created for each monitoring context.  You can create
-and remove monitoring contexts for multiple ``kdamond`` required use case using
-the ``mk_contexts`` and ``rm_contexts`` files.
-
-Writing the name of the new context to the ``mk_contexts`` file creates a
-directory of the name on the DAMON debugfs directory.  The directory will have
-DAMON debugfs files for the context. ::
-
-    # cd <debugfs>/damon
-    # ls foo
-    # ls: cannot access 'foo': No such file or directory
-    # echo foo > mk_contexts
-    # ls foo
-    # attrs  init_regions  kdamond_pid  schemes  target_ids
-
-If the context is not needed anymore, you can remove it and the corresponding
-directory by putting the name of the context to the ``rm_contexts`` file. ::
-
-    # echo foo > rm_contexts
-    # ls foo
-    # ls: cannot access 'foo': No such file or directory
-
-Note that ``mk_contexts``, ``rm_contexts``, and ``monitor_on_DEPRECATED`` files
-are in the root directory only.
-- 
2.39.5


