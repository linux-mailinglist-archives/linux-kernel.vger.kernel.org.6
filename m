Return-Path: <linux-kernel+bounces-524636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F16A3E551
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB14F19C4A34
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4583D2676F5;
	Thu, 20 Feb 2025 19:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQ1j2p9F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FB02676C8;
	Thu, 20 Feb 2025 19:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740080820; cv=none; b=DZ2sRVk5vvMBpvS3iGHTMIwDv71ayIY2PObrGixHZFQdpFpkPBzwwLxWxMI0UgsaZQ17y+Sh1K4cMSTpPvBxjcPjN0vBzJs/gdDg/vA+eD70obfYDNI9sMo2V7sz6LHWFiEwEdO8EvmmS6mOV/QzeoEeSpU2m4HvknxCubUlb5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740080820; c=relaxed/simple;
	bh=gpLkf9zlQXx9+WdyCFmZfQMDYQZmdg3U3lwl8lQVU8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LnJYcnZkT4rWHa36pb4VzTP0MZiazRkwsRiEC88d+qtEFce4HKhH0tDCxLrdjvy0nxwH/rkMRU5EkCsX4s/I7cjNfvZwzlZPrprm2ol0uVEsRUBORR/FzYM9cm1G22YoB3C6r+7VRywWGFsisjzIlXboNy6v7er2uy9BfOgzwKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQ1j2p9F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3DB2C4CED1;
	Thu, 20 Feb 2025 19:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740080820;
	bh=gpLkf9zlQXx9+WdyCFmZfQMDYQZmdg3U3lwl8lQVU8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XQ1j2p9FdJNVRlZZLTAB9nZE7l3lDOPSuLJ8cwJcZTqGShGQ0Ez9WwbtFRW19gDU6
	 ny570yEzYzz473rbwtVzOEBKKLamsqJBsFXuIY6NZiYGXjZXJtrPulkpvgfSK507JJ
	 OKrQTeu50f3G38/jZqdWlNcYxAKgAfROJWMV9AWGiU6DzhP0xWwo1cuHXDt5Jy7roc
	 E3VoKYCe9fpZyqLLeq3BktBihQyU3BHY1PTPZUK7gGK4dEMzvJmPFl0bfM87u/cuYu
	 bH/O0Vr6mecY5vzZgpvaD16rjTWgZTSA/vK4Zi/LEMh4Mo5OqrgCympoBiYHWFXilr
	 ib65nZ47RmwMA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 8/8] Docs/admin-guide/mm/damon/usage: update for {core,ops}_filters directories
Date: Thu, 20 Feb 2025 11:46:46 -0800
Message-Id: <20250220194646.37726-9-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250220194646.37726-1-sj@kernel.org>
References: <20250220194646.37726-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Document {core,ops}_filters directories on usage document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 31 ++++++++++++++------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index dc37bba96273..4b25c25d4f4f 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -82,7 +82,7 @@ comma (",").
     │ │ │ │ │ │ │ │ :ref:`goals <sysfs_schemes_quota_goals>`/nr_goals
     │ │ │ │ │ │ │ │ │ 0/target_metric,target_value,current_value
     │ │ │ │ │ │ │ :ref:`watermarks <sysfs_watermarks>`/metric,interval_us,high,mid,low
-    │ │ │ │ │ │ │ :ref:`filters <sysfs_filters>`/nr_filters
+    │ │ │ │ │ │ │ :ref:`{core_,ops_,}filters <sysfs_filters>`/nr_filters
     │ │ │ │ │ │ │ │ 0/type,matching,allow,memcg_path,addr_start,addr_end,target_idx,min,max
     │ │ │ │ │ │ │ :ref:`stats <sysfs_schemes_stats>`/nr_tried,sz_tried,nr_applied,sz_applied,sz_ops_filter_passed,qt_exceeds
     │ │ │ │ │ │ │ :ref:`tried_regions <sysfs_schemes_tried_regions>`/total_bytes
@@ -282,9 +282,10 @@ to ``N-1``.  Each directory represents each DAMON-based operation scheme.
 schemes/<N>/
 ------------
 
-In each scheme directory, five directories (``access_pattern``, ``quotas``,
-``watermarks``, ``filters``, ``stats``, and ``tried_regions``) and three files
-(``action``, ``target_nid`` and ``apply_interval``) exist.
+In each scheme directory, seven directories (``access_pattern``, ``quotas``,
+``watermarks``, ``core_filters``, ``ops_filters``, ``filters``, ``stats``, and
+``tried_regions``) and three files (``action``, ``target_nid`` and
+``apply_interval``) exist.
 
 The ``action`` file is for setting and getting the scheme's :ref:`action
 <damon_design_damos_action>`.  The keywords that can be written to and read
@@ -395,13 +396,24 @@ The ``interval`` should written in microseconds unit.
 
 .. _sysfs_filters:
 
-schemes/<N>/filters/
---------------------
+schemes/<N>/{core_,ops_,}filters/
+-------------------------------
 
-The directory for the :ref:`filters <damon_design_damos_filters>` of the given
+Directories for :ref:`filters <damon_design_damos_filters>` of the given
 DAMON-based operation scheme.
 
-In the beginning, this directory has only one file, ``nr_filters``.  Writing a
+``core_filters`` and ``ops_filters`` directories are for the filters handled by
+the DAMON core layer and operations set layer, respectively.  ``filters``
+directory can be used for installing filters regardless of their handled
+layers.  Filters that requested by ``core_filters`` and ``ops_filters`` will be
+installed before those of ``filters``.  All three directories have same files.
+
+Use of ``filters`` directory can make expecting evaluation orders of given
+filters with the files under directory bit confusing.  Users are hence
+recommended to use ``core_filters`` and ``ops_filters`` directories.  The
+``filters`` directory could be deprecated in future.
+
+In the beginning, the directory has only one file, ``nr_filters``.  Writing a
 number (``N``) to the file creates the number of child directories named ``0``
 to ``N-1``.  Each directory represents each filter.  The filters are evaluated
 in the numeric order.
@@ -410,7 +422,7 @@ Each filter directory contains nine files, namely ``type``, ``matching``,
 ``allow``, ``memcg_path``, ``addr_start``, ``addr_end``, ``min``, ``max``
 and ``target_idx``.  To ``type`` file, you can write the type of the filter.
 Refer to :ref:`the design doc <damon_design_damos_filters>` for available type
-names and their meanings.
+names, their meaning and on what layer those are handled.
 
 For ``memcg`` type, you can specify the memory cgroup of the interest by
 writing the path of the memory cgroup from the cgroups mount point to
@@ -430,6 +442,7 @@ the ``type`` and ``matching`` should be allowed or not.
 For example, below restricts a DAMOS action to be applied to only non-anonymous
 pages of all memory cgroups except ``/having_care_already``.::
 
+    # cd ops_filters/0/
     # echo 2 > nr_filters
     # # disallow anonymous pages
     echo anon > 0/type
-- 
2.39.5

