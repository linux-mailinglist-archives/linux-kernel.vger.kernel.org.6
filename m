Return-Path: <linux-kernel+bounces-300647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 262AF95E689
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 03:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C9C31F213C3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 01:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D790211187;
	Mon, 26 Aug 2024 01:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCq7jEWa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0F0D26D;
	Mon, 26 Aug 2024 01:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724637466; cv=none; b=mfO6mi8eXQeAoB/eCAfDP+TiOQpZOI/SL+s3fECIA/by3lb673iA8WZrCtLU8jA58I8nsikk3uDsswekNArvBqJKjeyEqsCklCJoR4HlXtip26CTIvz8dZEsOrvxiZCjARmBhEkc+Te+iSFJp4WuDPVTflF7RsbNjHzRt2jZRxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724637466; c=relaxed/simple;
	bh=pwhigTWrAj+bVozK+KGGpzFVunvCQGvZz9bEWXYLYdo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BGdOTXmaV5vS2g53aiToUQggw+wkGL2g5EWlTH7JO98FXm77le4d8tZcO5MfDElXNKicoOCvJ7mbVI3sfar9cZJw+PCoIC8zURXd0TaOIw7dyVSQB+BPoPwh9LLfB2ZJzJ/An//lMO9KiugqoUtOJJZ0Tgg6z6yxK5WXg3I+aMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCq7jEWa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C3B6C4DDE0;
	Mon, 26 Aug 2024 01:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724637466;
	bh=pwhigTWrAj+bVozK+KGGpzFVunvCQGvZz9bEWXYLYdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OCq7jEWaNCUAnL0Hi2mb5n2a3CBqOJKYLLq/2YULUe8usYzcUoIQec0yQwu89wPTn
	 Y0Dm8ond2Y2Ufb5RwVe8BxHVrjIZ9gy+apYD2V+5Sry1dQUwSC8BcfyLo95m30b2Xz
	 mJLG+P1Huw/+v6D2j9yudhqqMLEs0GAtPfo3ohgkgWdnFrP9YPhM0CjubC3uAxXfMH
	 mPoscYnccTUcKyxEY/3SDo5HqdBthOTmIC7oxfh7j4ngvNpA7RCXc/ZxdVN6gLgo0A
	 IAynApN0jkSrZ/KPfd9ImqB8qXzypMi1ivViaNd7uTh0l/X15U2jnuKvgKd6sQCB4D
	 pl37du2NiQVZw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Hu Haowen <2023002089@link.tyut.edu.cn>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] Docs/damon: use damonitor GitHub organization instead of awslabs
Date: Sun, 25 Aug 2024 18:57:39 -0700
Message-Id: <20240826015741.80707-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240826015741.80707-1-sj@kernel.org>
References: <20240826015741.80707-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

GitHub repos for non-kernel parts of DAMON project including 'damo',
'damon-tests' and 'damoos' will be moved[1] from 'awslabs' org to
'damonitor', by 2024-09-05.  Update related URLs in kernel tree.

[1] https://lore.kernel.org/20240813232158.83903-1-sj@kernel.org

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/start.rst              | 4 ++--
 Documentation/admin-guide/mm/damon/usage.rst              | 8 ++++----
 Documentation/mm/damon/design.rst                         | 2 +-
 Documentation/mm/damon/maintainer-profile.rst             | 8 ++++----
 .../translations/zh_CN/admin-guide/mm/damon/start.rst     | 4 ++--
 .../translations/zh_CN/admin-guide/mm/damon/usage.rst     | 8 ++++----
 .../translations/zh_TW/admin-guide/mm/damon/start.rst     | 4 ++--
 .../translations/zh_TW/admin-guide/mm/damon/usage.rst     | 8 ++++----
 8 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/start.rst b/Documentation/admin-guide/mm/damon/start.rst
index 054010a7f3d8..c4dddf6733cd 100644
--- a/Documentation/admin-guide/mm/damon/start.rst
+++ b/Documentation/admin-guide/mm/damon/start.rst
@@ -7,7 +7,7 @@ Getting Started
 This document briefly describes how you can use DAMON by demonstrating its
 default user space tool.  Please note that this document describes only a part
 of its features for brevity.  Please refer to the usage `doc
-<https://github.com/awslabs/damo/blob/next/USAGE.md>`_ of the tool for more
+<https://github.com/damonitor/damo/blob/next/USAGE.md>`_ of the tool for more
 details.
 
 
@@ -26,7 +26,7 @@ User Space Tool
 
 For the demonstration, we will use the default user space tool for DAMON,
 called DAMON Operator (DAMO).  It is available at
-https://github.com/awslabs/damo.  The examples below assume that ``damo`` is on
+https://github.com/damonitor/damo.  The examples below assume that ``damo`` is on
 your ``$PATH``.  It's not mandatory, though.
 
 Because DAMO is using the sysfs interface (refer to :doc:`usage` for the
diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 26df6cfa4441..d9be9f7caa7d 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -7,19 +7,19 @@ Detailed Usages
 DAMON provides below interfaces for different users.
 
 - *DAMON user space tool.*
-  `This <https://github.com/awslabs/damo>`_ is for privileged people such as
+  `This <https://github.com/damonitor/damo>`_ is for privileged people such as
   system administrators who want a just-working human-friendly interface.
   Using this, users can use the DAMON’s major features in a human-friendly way.
   It may not be highly tuned for special cases, though.  For more detail,
   please refer to its `usage document
-  <https://github.com/awslabs/damo/blob/next/USAGE.md>`_.
+  <https://github.com/damonitor/damo/blob/next/USAGE.md>`_.
 - *sysfs interface.*
   :ref:`This <sysfs_interface>` is for privileged user space programmers who
   want more optimized use of DAMON.  Using this, users can use DAMON’s major
   features by reading from and writing to special sysfs files.  Therefore,
   you can write and use your personalized DAMON sysfs wrapper programs that
   reads/writes the sysfs files instead of you.  The `DAMON user space tool
-  <https://github.com/awslabs/damo>`_ is one example of such programs.
+  <https://github.com/damonitor/damo>`_ is one example of such programs.
 - *Kernel Space Programming Interface.*
   :doc:`This </mm/damon/api>` is for kernel space programmers.  Using this,
   users can utilize every feature of DAMON most flexibly and efficiently by
@@ -543,7 +543,7 @@ memory rate becomes larger than 60%, or lower than 30%". ::
     # echo 300 > watermarks/low
 
 Please note that it's highly recommended to use user space tools like `damo
-<https://github.com/awslabs/damo>`_ rather than manually reading and writing
+<https://github.com/damonitor/damo>`_ rather than manually reading and writing
 the files as above.  Above is only for an example.
 
 .. _tracepoint:
diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 8730c246ceaa..f9c50525bdbf 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -586,7 +586,7 @@ API, and return the results to the user-space.
 The ABIs are designed to be used for user space applications development,
 rather than human beings' fingers.  Human users are recommended to use such
 user space tools.  One such Python-written user space tool is available at
-Github (https://github.com/awslabs/damo), Pypi
+Github (https://github.com/damonitor/damo), Pypi
 (https://pypistats.org/packages/damo), and Fedora
 (https://packages.fedoraproject.org/pkgs/python-damo/damo/).
 
diff --git a/Documentation/mm/damon/maintainer-profile.rst b/Documentation/mm/damon/maintainer-profile.rst
index feccf6a0f6c3..048b78e6d989 100644
--- a/Documentation/mm/damon/maintainer-profile.rst
+++ b/Documentation/mm/damon/maintainer-profile.rst
@@ -91,9 +91,9 @@ list (damon@lists.linux.dev).
 .. [1] https://git.kernel.org/akpm/mm/h/mm-unstable
 .. [2] https://git.kernel.org/sj/h/damon/next
 .. [3] https://git.kernel.org/akpm/mm/h/mm-stable
-.. [4] https://github.com/awslabs/damon-tests/blob/master/corr/run.sh#L49
-.. [5] https://github.com/awslabs/damon-tests/blob/master/corr/tests/kunit.sh
-.. [6] https://github.com/awslabs/damon-tests/tree/master/corr
-.. [7] https://github.com/awslabs/damon-tests/tree/master/perf
+.. [4] https://github.com/damonitor/damon-tests/blob/master/corr/run.sh#L49
+.. [5] https://github.com/damonitor/damon-tests/blob/master/corr/tests/kunit.sh
+.. [6] https://github.com/damonitor/damon-tests/tree/master/corr
+.. [7] https://github.com/damonitor/damon-tests/tree/master/perf
 .. [8] https://github.com/damonitor/hackermail
 .. [9] https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing
diff --git a/Documentation/translations/zh_CN/admin-guide/mm/damon/start.rst b/Documentation/translations/zh_CN/admin-guide/mm/damon/start.rst
index bf21ff84f396..cff7b6f98c59 100644
--- a/Documentation/translations/zh_CN/admin-guide/mm/damon/start.rst
+++ b/Documentation/translations/zh_CN/admin-guide/mm/damon/start.rst
@@ -15,7 +15,7 @@
 
 本文通过演示DAMON的默认用户空间工具，简要地介绍了如何使用DAMON。请注意，为了简洁
 起见，本文档只描述了它的部分功能。更多细节请参考该工具的使用文档。
-`doc <https://github.com/awslabs/damo/blob/next/USAGE.md>`_ .
+`doc <https://github.com/damonitor/damo/blob/next/USAGE.md>`_ .
 
 
 前提条件
@@ -31,7 +31,7 @@
 ------------
 
 在演示中，我们将使用DAMON的默认用户空间工具，称为DAMON Operator（DAMO）。它可以在
-https://github.com/awslabs/damo找到。下面的例子假设DAMO在你的$PATH上。当然，但
+https://github.com/damonitor/damo找到。下面的例子假设DAMO在你的$PATH上。当然，但
 这并不是强制性的。
 
 因为DAMO使用了DAMON的sysfs接口（详情请参考:doc:`usage`），你应该确保
diff --git a/Documentation/translations/zh_CN/admin-guide/mm/damon/usage.rst b/Documentation/translations/zh_CN/admin-guide/mm/damon/usage.rst
index da2745464ece..50f6f0b6bf11 100644
--- a/Documentation/translations/zh_CN/admin-guide/mm/damon/usage.rst
+++ b/Documentation/translations/zh_CN/admin-guide/mm/damon/usage.rst
@@ -16,16 +16,16 @@
 DAMON 为不同的用户提供了下面这些接口。
 
 - *DAMON用户空间工具。*
-  `这 <https://github.com/awslabs/damo>`_ 为有这特权的人， 如系统管理员，希望有一个刚好
+  `这 <https://github.com/damonitor/damo>`_ 为有这特权的人， 如系统管理员，希望有一个刚好
   可以工作的人性化界面。
   使用它，用户可以以人性化的方式使用DAMON的主要功能。不过，它可能不会为特殊情况进行高度调整。
   它同时支持虚拟和物理地址空间的监测。更多细节，请参考它的 `使用文档
-  <https://github.com/awslabs/damo/blob/next/USAGE.md>`_。
+  <https://github.com/damonitor/damo/blob/next/USAGE.md>`_。
 - *sysfs接口。*
   :ref:`这 <sysfs_interface>` 是为那些希望更高级的使用DAMON的特权用户空间程序员准备的。
   使用它，用户可以通过读取和写入特殊的sysfs文件来使用DAMON的主要功能。因此，你可以编写和使
   用你个性化的DAMON sysfs包装程序，代替你读/写sysfs文件。  `DAMON用户空间工具
-  <https://github.com/awslabs/damo>`_ 就是这种程序的一个例子  它同时支持虚拟和物理地址
+  <https://github.com/damonitor/damo>`_ 就是这种程序的一个例子  它同时支持虚拟和物理地址
   空间的监测。注意，这个界面只提供简单的监测结果 :ref:`统计 <damos_stats>`。对于详细的监测
   结果，DAMON提供了一个:ref:`跟踪点 <tracepoint>`。
 - *debugfs interface.*
@@ -332,7 +332,7 @@ tried_regions/<N>/
     # echo 500 > watermarks/mid
     # echo 300 > watermarks/low
 
-请注意，我们强烈建议使用用户空间的工具，如 `damo <https://github.com/awslabs/damo>`_ ，
+请注意，我们强烈建议使用用户空间的工具，如 `damo <https://github.com/damonitor/damo>`_ ，
 而不是像上面那样手动读写文件。以上只是一个例子。
 
 debugfs接口
diff --git a/Documentation/translations/zh_TW/admin-guide/mm/damon/start.rst b/Documentation/translations/zh_TW/admin-guide/mm/damon/start.rst
index 1822956be0e0..57d36bfbb1b3 100644
--- a/Documentation/translations/zh_TW/admin-guide/mm/damon/start.rst
+++ b/Documentation/translations/zh_TW/admin-guide/mm/damon/start.rst
@@ -15,7 +15,7 @@
 
 本文通過演示DAMON的默認用戶空間工具，簡要地介紹瞭如何使用DAMON。請注意，爲了簡潔
 起見，本文檔只描述了它的部分功能。更多細節請參考該工具的使用文檔。
-`doc <https://github.com/awslabs/damo/blob/next/USAGE.md>`_ .
+`doc <https://github.com/damonitor/damo/blob/next/USAGE.md>`_ .
 
 
 前提條件
@@ -31,7 +31,7 @@
 ------------
 
 在演示中，我們將使用DAMON的默認用戶空間工具，稱爲DAMON Operator（DAMO）。它可以在
-https://github.com/awslabs/damo找到。下面的例子假設DAMO在你的$PATH上。當然，但
+https://github.com/damonitor/damo找到。下面的例子假設DAMO在你的$PATH上。當然，但
 這並不是強制性的。
 
 因爲DAMO使用了DAMON的sysfs接口（詳情請參考:doc:`usage`），你應該確保
diff --git a/Documentation/translations/zh_TW/admin-guide/mm/damon/usage.rst b/Documentation/translations/zh_TW/admin-guide/mm/damon/usage.rst
index 7464279f9b7d..fbbbbad59ee4 100644
--- a/Documentation/translations/zh_TW/admin-guide/mm/damon/usage.rst
+++ b/Documentation/translations/zh_TW/admin-guide/mm/damon/usage.rst
@@ -16,16 +16,16 @@
 DAMON 爲不同的用戶提供了下面這些接口。
 
 - *DAMON用戶空間工具。*
-  `這 <https://github.com/awslabs/damo>`_ 爲有這特權的人， 如系統管理員，希望有一個剛好
+  `這 <https://github.com/damonitor/damo>`_ 爲有這特權的人， 如系統管理員，希望有一個剛好
   可以工作的人性化界面。
   使用它，用戶可以以人性化的方式使用DAMON的主要功能。不過，它可能不會爲特殊情況進行高度調整。
   它同時支持虛擬和物理地址空間的監測。更多細節，請參考它的 `使用文檔
-  <https://github.com/awslabs/damo/blob/next/USAGE.md>`_。
+  <https://github.com/damonitor/damo/blob/next/USAGE.md>`_。
 - *sysfs接口。*
   :ref:`這 <sysfs_interface>` 是爲那些希望更高級的使用DAMON的特權用戶空間程序員準備的。
   使用它，用戶可以通過讀取和寫入特殊的sysfs文件來使用DAMON的主要功能。因此，你可以編寫和使
   用你個性化的DAMON sysfs包裝程序，代替你讀/寫sysfs文件。  `DAMON用戶空間工具
-  <https://github.com/awslabs/damo>`_ 就是這種程序的一個例子  它同時支持虛擬和物理地址
+  <https://github.com/damonitor/damo>`_ 就是這種程序的一個例子  它同時支持虛擬和物理地址
   空間的監測。注意，這個界面只提供簡單的監測結果 :ref:`統計 <damos_stats>`。對於詳細的監測
   結果，DAMON提供了一個:ref:`跟蹤點 <tracepoint>`。
 - *debugfs interface.*
@@ -332,7 +332,7 @@ tried_regions/<N>/
     # echo 500 > watermarks/mid
     # echo 300 > watermarks/low
 
-請注意，我們強烈建議使用用戶空間的工具，如 `damo <https://github.com/awslabs/damo>`_ ，
+請注意，我們強烈建議使用用戶空間的工具，如 `damo <https://github.com/damonitor/damo>`_ ，
 而不是像上面那樣手動讀寫文件。以上只是一個例子。
 
 debugfs接口
-- 
2.39.2


